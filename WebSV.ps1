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

# ブラウザーから受け取った相対パスを、Wikiフォルダー内の絶対パスへ変換する。
# GetFullPathで「..」を解決した後にルート配下か確認し、パストラバーサルを防止する。
function Resolve-WikiPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RelativePath,

        [switch]$MarkdownOnly
    )

    $directorySeparator = [System.IO.Path]::DirectorySeparatorChar
    $repositoryRoot = [System.IO.Path]::GetFullPath($PSScriptRoot)
    $repositoryPrefix = $repositoryRoot.TrimEnd($directorySeparator) + $directorySeparator
    $normalizedRelativePath = $RelativePath.Replace('/', $directorySeparator).TrimStart([char[]]@($directorySeparator))
    $candidatePath = [System.IO.Path]::GetFullPath(
        [System.IO.Path]::Combine($repositoryRoot, $normalizedRelativePath)
    )

    if (-not $candidatePath.StartsWith($repositoryPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "The requested path is outside the wiki folder."
    }

    if ($MarkdownOnly) {
        $documentRoot = [System.IO.Path]::GetFullPath(
            [System.IO.Path]::Combine($repositoryRoot, 'doc')
        )
        $documentPrefix = $documentRoot.TrimEnd($directorySeparator) + $directorySeparator
        $isMarkdown = [System.IO.Path]::GetExtension($candidatePath) -ieq '.md'

        if (-not $candidatePath.StartsWith($documentPrefix, [System.StringComparison]::OrdinalIgnoreCase) -or -not $isMarkdown) {
            throw "Wiki pages must be .md files inside the doc folder."
        }
    }

    return $candidatePath
}

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

            [System.Net.HttpListenerContext]$Context = $null
            [MyWebSV]$MyWebSV = $null
            try {
                $MyWebSV = $AsyncResult.AsyncState
                [Net.HttpListener]$listener = $MyWebSV.Listener
                $Context = $Listener.EndGetContext($AsyncResult)
                [System.Net.HttpListenerRequest]$Request = $Context.Request
                [System.Net.HttpListenerResponse]$Response = $context.Response
                
                if ($Listener.IsListening -eq $false ) {
                    Write-Host 'Listener Stop'
                    exit
                }

                #再起処理
                [void]$MyWebSV.Listener.BeginGetContext($MyWebSV.ListenerCallback, $MyWebSV)
                
                $MyWebSV.Count += 1
                write-host 'Loop Count:' $MyWebSV.Count
                write-host 'HttpMethod:' $Request.HttpMethod
                write-host 'Cookies:' $Request.Cookies
                write-host 'RawUrl:' $Request.RawUrl                
                $decodeUrl = [System.Net.WebUtility]::UrlDecode($Context.Request.RawUrl)
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
                else {
                    $Response.StatusCode = [System.Net.HttpStatusCode]::MethodNotAllowed
                    $Content = '405 Method Not Allowed'
                }
                $MyWebSV.SendContent($Context, $Content)
            }
            catch {
                Write-Error $_.Exception
                if ($null -ne $Context -and $null -ne $MyWebSV) {
                    try {
                        $Context.Response.StatusCode = [System.Net.HttpStatusCode]::InternalServerError
                        $MyWebSV.SendContent($Context, '500 Internal Server Error')
                    }
                    catch {
                        $Context.Response.Abort()
                    }
                }
            }
        })

    [string] GETMethod(
                [System.Net.HttpListenerContext]$Context) 
    {
        $Content = '404 Not Found'
        [System.Net.HttpListenerRequest]$Request = $Context.Request
        [System.Net.HttpListenerResponse]$Response = $context.Response

        #初期値
        $Response.StatusCode = [System.net.HttpStatusCode]::NotFound
        $FileName = $Request.Url.LocalPath
        try {
            $FullPath = Resolve-WikiPath -RelativePath $FileName
        }
        catch {
            $Response.StatusCode = [System.Net.HttpStatusCode]::Forbidden
            return '403 Forbidden'
        }

        if (Test-Path -LiteralPath $FullPath -PathType Leaf) {
            $Content = [System.IO.File]::ReadAllText($FullPath, [System.Text.Encoding]::UTF8)
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

        if ($null -ne $Context.Request.ContentType -and $Context.Request.ContentType.StartsWith('application/json')) {
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
            $PageName = [System.Net.WebUtility]::UrlDecode($RequestHash.PageName)
            $RequestFileName = [System.Net.WebUtility]::UrlDecode($RequestHash.FileName)

            $ResponseHash.ButtonID = $ButtonID
            $ResponseHash.PageName = $PageName
            $ResponseHash.FileName = $RequestFileName 

            $allowedButtonIds = @('Open', 'Edit', 'Save', 'ALLPage', 'FindPage', 'ShellOpen', 'NewPage', 'ReNamePage', 'DeletePage')
            if ($allowedButtonIds -notcontains $ButtonID) {
                $Response.StatusCode = [System.Net.HttpStatusCode]::BadRequest
                $ResponseHash.content = 'Unknown operation.'
                return (ConvertTo-Json $ResponseHash)
            }

            $FullPath = $null
            if ($ButtonID -ne 'ShellOpen') {
                try {
                    $FullPath = Resolve-WikiPath -RelativePath $RequestFileName -MarkdownOnly
                }
                catch {
                    $Response.StatusCode = [System.Net.HttpStatusCode]::Forbidden
                    $ResponseHash.content = $_.Exception.Message
                    return (ConvertTo-Json $ResponseHash)
                }
            }

            Write-Host 'TargetButtonID：' $ButtonID
            if ($ButtonID -eq 'Save') {
                $RequestContent = [System.Net.WebUtility]::UrlDecode($RequestHash.Content)
                write-host 'Savefile=' $FullPath
                [System.IO.File]::WriteAllText($FullPath, $RequestContent, [System.Text.UTF8Encoding]::new($false))
            }
            if ($ButtonID -eq 'ALLPage') {
                $CheckPath = Resolve-WikiPath -RelativePath 'doc'
                $AllPages = Get-ChildItem -LiteralPath $CheckPath -Filter '*.md' -File | Select-Object Name, CreationTime, LastWriteTime
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
                $RequestContent = [System.Net.WebUtility]::UrlDecode($RequestHash.Content)
                $ResponseHash.FullPath = $FullPath
                $CheckPath = Join-Path (Resolve-WikiPath -RelativePath 'doc') '*.md'
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
                $ResponseHash.FullPath = $FullPath
                $ResponseHash.content = ""
                $ResponseHash.PageName = $PageName
                $Response.StatusCode = [System.net.HttpStatusCode]::OK
            }
            if ($ButtonID -eq 'ReNamePage') {
                $SrcFileName = [System.Net.WebUtility]::UrlDecode($RequestHash.Content)
                $SrcFullPath = Resolve-WikiPath -RelativePath $SrcFileName -MarkdownOnly
                $DstFullPath = $FullPath
                Write-Host 'src=' $SrcFullPath 
                Write-Host 'dst=' $DstFullPath 

                if (Test-Path -LiteralPath $SrcFullPath -PathType Leaf) {
                    Move-Item -LiteralPath $SrcFullPath -Destination $DstFullPath
                }
            }
            if ($ButtonID -eq 'DeletePage') {
                if (Test-Path -LiteralPath $FullPath -PathType Leaf) {
                    Remove-Item -LiteralPath $FullPath
                }
            }

            $ResponseHash.FullPath = $FullPath
            Write-Host $FullPath
            if ($null -ne $FullPath -and (Test-Path -LiteralPath $FullPath -PathType Leaf)) {
                #読み込み
                $ResponseText = [System.IO.File]::ReadAllText($FullPath, [System.Text.Encoding]::UTF8)

                $fileInfo = Get-Item -LiteralPath $FullPath
                $CreationTime = $fileInfo.CreationTime.ToString()
                $LastWriteTime = $fileInfo.LastWriteTime.ToString()
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
        else {
            $Response.StatusCode = [System.Net.HttpStatusCode]::UnsupportedMediaType
            $Content = '{"content":"Content-Type must be application/json."}'
        }
        return $Content
    }

    [void] SendContent(
        [System.Net.HttpListenerContext]$Context, $MyContent) 
    {
        [System.Net.HttpListenerResponse]$Response = $Context.Response
        #ContentTypeに応じた出力方法の設定
        if ($Context.Request.HttpMethod -eq 'POST') {
            $Response.ContentType = 'application/json; charset=utf-8'
        }
        else {
            $extension = [System.IO.Path]::GetExtension($Context.Request.Url.LocalPath)
            $Response.ContentType = switch ($extension.ToLowerInvariant()) {
                '.css' { 'text/css; charset=utf-8' }
                '.js' { 'text/javascript; charset=utf-8' }
                '.html' { 'text/html; charset=utf-8' }
                '.md' { 'text/markdown; charset=utf-8' }
                default { 'text/plain; charset=utf-8' }
            }
        }
        $Content = [string]$MyContent
        $Bytes = [System.Text.Encoding]::UTF8.GetBytes($Content)
        $Response.ContentLength64 = $Bytes.Length
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
            [void]$this.Listener.BeginGetContext($this.ListenerCallback, $this)
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
