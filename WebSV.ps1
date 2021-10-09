# New-ScriptblockCallbackは、Register-ObjectEventを使った非同期処理の要のコード
# Polaris　から移植
# https://powershell.github.io/Polaris/docs/api/New-ScriptblockCallback.html
# https://github.com/PowerShell/Polaris.git
# <---  New-ScriptblockCallback.ps1 から必要部を移植　開始    --->
function New-ScriptblockCallback {
    param(
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [scriptblock]$Callback
    )

    # is this type already defined?
    if (-not ("CallbackEventBridge" -as [type])) {
        Add-Type @"
            using System;

            public sealed class CallbackEventBridge
            {
                public event AsyncCallback CallbackComplete = delegate { };

                private CallbackEventBridge() {}

                private void CallbackInternal(IAsyncResult result)
                {
                    CallbackComplete(result);
                }

                public AsyncCallback Callback
                {
                    get { return new AsyncCallback(CallbackInternal); }
                }

                public static CallbackEventBridge Create()
                {
                    return new CallbackEventBridge();
                }
            }
"@
    }
    $bridge = [callbackeventbridge]::create()
    Register-ObjectEvent -input $bridge -EventName callbackcomplete -action $callback -messagedata $args > $null
    $bridge.callback
}
# <---  New-ScriptblockCallback.ps1 から必要部を移植　終了    --->
# もし、New-ScriptblockCallback.ps１をリンクする場合は、移植コードをカットし、↓をコメントアウト
#. ".\\New-ScriptblockCallback.ps1"

class MyWebSV {
    
    [String]$Name
    [String]$UriPrefix
    [Int64]$Count
    [System.Net.HttpListener]$Listener
    $shell
    #コールバック
    $ListenerCallback = (New-ScriptblockCallback -Callback {
            param(
                [System.IAsyncResult]
                $AsyncResult
            )

            try {
                [MyWebSV]$MyWebSV = $AsyncResult.AsyncState
                [Net.HttpListener]$listener = $MyWebSV.Listener
                [System.Net.HttpListenerContext]$Context
                $Context = $Listener.EndGetContext($AsyncResult)
                [System.Net.HttpListenerRequest]$Request = $Context.Request
                [System.Net.HttpListenerResponse]$Response = $context.Response
                
                if ($Listener.IsListening -eq $false ) {
                    Write-Host 'Listener Stop'
                    exit
                }

                if ( $null -eq $Context) {
                    $Response.Close()
                    $MyWebSV.Listener.Close()
                    break
                }
                
                #再起処理
                $MyWebSV.Listener.BeginGetContext($MyWebSV.ListenerCallback, $MyWebSV)
                
                $MyWebSV.Count += 1
                write-host 'Loop Count:' $MyWebSV.Count
                write-host 'HttpMethod:' $Request.HttpMethod
                write-host 'Cookies:' $Request.Cookies
                write-host 'RawUrl:' $Request.RawUrl                
                $decodeUrl =  [System.Web.HttpUtility]::UrlDecode($Context.Request.RawUrl)
                Write-Host $decodeUrl
                write-host 'ContentType:' $Request.ContentType
                
                [string]$Content = $null
                if ( $Context.Request.HttpMethod -eq 'GET'){
                    write-host 'GETMethod'
                    $Content = $MyWebSV.GETMethod($Context)

                }elseif ($Context.Request.HttpMethod -eq 'POST') {
                    write-host 'POSTMethod'
                    $Content = $MyWebSV.POSTMethod($Context)                    
                }
                $MyWebSV.SendContent($Context, $Content);
            }
            catch {
                Write-Host ($_.Exception)
                Write-Host ($_.Exception.Source )
                $context.Response.Close()
                $MyWebSV.Listener.Close()
                break
            }
        })

    [string] GETMethod(
                [System.Net.HttpListenerContext]$Context) 
    {
        $Content = $null
        [bool]$IsExist = $true
        [System.Net.HttpListenerRequest]$Request = $Context.Request
        [System.Net.HttpListenerResponse]$Response = $context.Response

        #初期値
        $Response.StatusCode = [System.net.HttpStatusCode]::NotFound
        $Content = '404 not Found'
        $FileName = $Request.Url.LocalPath
        $FullPath = Join-Path $PSScriptRoot $FileName
        #フォルダチェック
        $RequestedItem = Get-Item -LiteralPath $FullPath
        if ($RequestedItem.Attributes -match "Directory") {
            $IsExist = $false
        }
        #ファイル存在チェック
        if (!(Test-Path $FullPath)) {
            $IsExist = $false
        }
        #チェックOKの場合、コンテンツ取得
        if ($IsExist -eq $true) {
            $streamReader = New-Object System.IO.StreamReader($FullPath, [System.Text.Encoding]::UTF8)
            $Content = $streamReader.ReadToEnd()
            $Response.StatusCode = [System.net.HttpStatusCode]::OK
        }
        return $Content
    }

    [string] POSTMethod([System.Net.HttpListenerContext]$Context) 
    {
        $Content = $null
        $RequestText = $null
        $ResponseText  = $null
        $ResponseHash = $null 
        $RequestHash = $null 
        $ButtonID = $null

        [System.Net.HttpListenerRequest]$Request = $Context.Request
        [System.Net.HttpListenerResponse]$Response = $context.Response

        #初期値
        $Response.StatusCode = [System.net.HttpStatusCode]::NotFound
        $Content = $null

        if ( $Context.Request.ContentType -eq 'application/json' ) {
            #レスポンス用Hash初期値
            $ResponseHash = @{
                ButtonID      = "-"
                FullPath      = "-"
                CreationTime  = "-"
                LastWriteTime = "-"
                FileName      = "-" 
                PageName      = "-" 
                content       = ""
            }

            #index.htmlからの指示指示情報(JSON形式　ButtonID、FileName)を取得
            [System.IO.Stream]$body = $Request.InputStream
            [System.Text.Encoding]$encoding = $request.ContentEncoding
            [System.IO.StreamReader]$StreamReader = [System.IO.StreamReader]::new($body, $encoding)
            $RequestText = $StreamReader.ReadToEnd()
            $StreamReader.Close()
            $body.Close()

            #ワーク変数
            $RequestHash = (ConvertFrom-Json $RequestText)
            $ButtonID = $RequestHash.ButtonID
            $PageName = [System.Web.HttpUtility]::UrlDecode($RequestHash.PageName)
            $RequestFileName = [System.Web.HttpUtility]::UrlDecode($RequestHash.FileName)

            $ResponseHash.ButtonID = $ButtonID
            $ResponseHash.PageName = $PageName
            $ResponseHash.FileName = $RequestFileName 

             write-host 'TargetButtonID：' $ButtonID
            if ($ButtonID -eq 'Save') {
                $RequestContent = [System.Web.HttpUtility]::UrlDecode($RequestHash.Content)
                $FullPath = Join-Path $PSScriptRoot $RequestFileName
                write-host 'Savefile=' $FullPath
                $StreamWriter = New-Object System.IO.StreamWriter($FullPath, $false, [Text.Encoding]::GetEncoding("UTF-8"))
                # テキスト書き込み
                $StreamWriter.WriteLine($RequestContent)
                # ファイルストリームクローズ
                $StreamWriter.Close()
            }
            if ($ButtonID -eq 'ALLPage') {
                $CheckPath = Join-Path $PSScriptRoot "/doc/"
                $FullPath = Join-Path $PSScriptRoot $RequestFileName
                $AllPages = Get-ChildItem -path  $CheckPath *.md | Select-Object name, CreationTime, LastWriteTime                     
                #出力結果作成　Markdownの文法で
                [string]$AllData = $null                    
                $AllData += '|FileName|CreationTime|LastWriteTime|' + [Environment]::NewLine
                $AllData += '|:-|:-|:-|' + [Environment]::NewLine                    
                for ($i = 0; $i -lt $AllPages.Count; $i++) {
                    $FileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($AllPages[$i].Name)
                    $lineData = '|[' + $FileNameWithoutExtension + '](' + $FileNameWithoutExtension + ')|' + $AllPages[$i].CreationTime.tostring() + '|' + $AllPages[$i].LastWriteTime.tostring() + '|' + [Environment]::NewLine
                    $AllData += $lineData 
                }
                #出力
                $UTF8NoBomEnc = New-Object System.Text.UTF8Encoding $False
                [System.IO.File]::WriteAllLines($FullPath, $AllData, $UTF8NoBomEnc)
            }
            if ($ButtonID -eq 'FindPage') {
                $RequestContent = [System.Web.HttpUtility]::UrlDecode($RequestHash.Content)
                $FullPath = Join-Path $PSScriptRoot $RequestFileName
                $ResponseHash.FullPath = $FullPath
                $CheckPath = Join-Path $PSScriptRoot "/doc/*"
                [string]$AllData = '' 
                $find = ''
                if ('' -eq $RequestContent)
                {
                    $AllData = 'Not Found'
                }else{
                    Write-Host '$CheckPath:' $CheckPath
                    Write-Host '$RequestContent:' $RequestContent
                    $find = Select-String -Path $CheckPath -Pattern $RequestContent 
                    #出力結果作成　Markdownの文法で                    
                    $AllData += '|FileName|LineNumber|Line|Pattern|' + [Environment]::NewLine
                    $AllData += '|:-|:-|:-|:-|' + [Environment]::NewLine                    
                    for ($i = 0; $i -lt $find.Count; $i++) {
                        $FileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($find[$i].Filename)
                        $lineData = '|[' + $FileNameWithoutExtension + '](' + $FileNameWithoutExtension + ')|' + $find[$i].LineNumber + '|' + $find[$i].Line + '|' + $find[$i].Pattern + '|' + [Environment]::NewLine
                        $AllData += $lineData 
                    }
                }
                #出力
                $UTF8NoBomEnc = New-Object System.Text.UTF8Encoding $False
                [System.IO.File]::WriteAllLines($FullPath, $AllData, $UTF8NoBomEnc)
            }
            if ($ButtonID -eq 'ShellOpen') {
                Write-Host 'OpenFolder' $PageName
                #shell.open でフォルダやファイルを開く（よくVBSやVBAでやる方法）
                $this.shell.Open($PageName)
                #shell.openの戻り値がわからないため、実行＝OKとする。
                $Response.StatusCode = [System.net.HttpStatusCode]::OK
                $ResponseHash.content = 'Exec shell Open Target:' + $PageName
                $ResponseHash.PageName = $PageName
            }
            if ($ButtonID -eq 'NewPage') {
                $FullPath = Join-Path $PSScriptRoot $RequestFileName
                $ResponseHash.FullPath = $FullPath
                $ResponseHash.content = ""
                $ResponseHash.PageName = $PageName
                $Response.StatusCode = [System.net.HttpStatusCode]::OK
            }
            if ($ButtonID -eq 'ReNamePage') {
                $SrcFileName = [System.Web.HttpUtility]::UrlDecode($RequestHash.Content)
                $DstFileName = $RequestFileName
                $SrcFullPath = Join-Path $PSScriptRoot $SrcFileName
                $DstFullPath = Join-Path $PSScriptRoot $DstFileName
                Write-Host 'src=' $SrcFullPath 
                Write-Host 'dst=' $DstFullPath 

                if (Test-Path $SrcFullPath) {
                    Rename-Item -Path $SrcFullPath -NewName $DstFullPath
                }
            }
            if ($ButtonID -eq 'DeletePage') {
                $FullPath = Join-Path $PSScriptRoot $RequestFileName               
                if (Test-Path $FullPath) {
                    Remove-Item -Path $FullPath 
                }else {
                    
                }

            }

            $FullPath = Join-Path $PSScriptRoot $RequestFileName
            $ResponseHash.FullPath = $FullPath
            Write-Host $FullPath
            if (Test-Path $FullPath) {
                #読み込み
                $streamReader = New-Object System.IO.StreamReader($FullPath, [System.Text.Encoding]::UTF8)
                $ResponseText = $streamReader.ReadToEnd()
                $streamReader.Close()

                $CreationTime = (Get-ItemProperty $FullPath).CreationTime.ToString()
                $LastWriteTime = (Get-ItemProperty $FullPath).LastWriteTime.ToString()
                #レスポンス用にJSONに値を詰め込む、mdファイルがある場合
                $ResponseHash.FullPath = $FullPath
                $ResponseHash.CreationTime = $CreationTime
                $ResponseHash.LastWriteTime = $LastWriteTime
                $ResponseHash.content = $ResponseText
                $Response.StatusCode = [System.net.HttpStatusCode]::OK
            }
            $json = (ConvertTo-Json $ResponseHash)
            $Content = $json
        }
        return $Content
    }

    [void] SendContent(
        [System.Net.HttpListenerContext]$Context, $MyContent) 
    {
        [System.Net.HttpListenerResponse]$Response = $context.Response
        #ContentTypeに応じた出力方法の設定
        if ( $Context.Request.ContentType -eq 'application/json' ) {
            $Response.ContentType = "application/json"
            $Content = $MyContent
        }
        elseif ( $Context.Request.ContentType -eq 'text/plain' ) {
            $Content = $MyContent
            $Response.ContentType = "text/plain"
        }
        elseif ( $Context.Request.ContentType -eq 'text/html' ) {
            $Content = $MyContent
            $Response.ContentType = "text/html"
        }
        else {
            $Content = $MyContent
            $Response.ContentType = "text/html"
        }
        $Bytes = [System.Text.Encoding]::UTF8.GetBytes($Content)
        $Response.OutputStream.Write($Bytes, 0, $Bytes.Length)
        $Response.Close()
        $Response.Dispose()
    }

    #コンストラクタ
    MyWebSV (
        [String]$Name, 
        [String]$UriPrefix, 
        [Int64]$Count
    ) {
        $this.Name = $Name
        $this.UriPrefix = $UriPrefix         
        $this.Count = $Count
        $this.shell = new-object -com Shell.Application
    }

    [void] Start () {
        try {
            $this.listener = [Net.HttpListener]::new()
            $this.listener.Prefixes.Add($this.UriPrefix)
            $this.listener.Start()
            $IAsyncResult = $this.Listener.BeginGetContext($this.ListenerCallback, $this)
        }
        catch {
            Write-Error($_.Exception)
        }
    }

}
function Start-WebSV {
    $UriPrefix = "http://localhost:8000/"
    $IndexHTML = $UriPrefix + 'index.html'
    $MyWebSV = [MyWebSV]::new("MyLocalWebSV", $UriPrefix, 0 ) 
    $MyWebSV.Start()
    Write-Host "Local Server Start" $UriPrefix    
    Write-Host "Local Server Start" $IndexHTML    
    #システムデフォルトのブラウザでローカルサーバで起動したindex.htmlを開く
    Start-Process  $IndexHTML
}

Start-WebSV
