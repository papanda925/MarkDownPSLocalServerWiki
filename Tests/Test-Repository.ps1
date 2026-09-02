$ErrorActionPreference = 'Stop'

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$failures = [System.Collections.Generic.List[string]]::new()

$powerShellFiles = @(
    'StartWiki.ps1'
    'SrartWiki.ps1'
    'WebSV.ps1'
)

foreach ($relativePath in $powerShellFiles) {
    $path = Join-Path $repositoryRoot $relativePath
    $tokens = $null
    $parseErrors = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile(
        $path,
        [ref]$tokens,
        [ref]$parseErrors
    )

    foreach ($parseError in $parseErrors) {
        $failures.Add("${relativePath}: $($parseError.Message)")
    }
}

$serverSource = Get-Content -LiteralPath (Join-Path $repositoryRoot 'WebSV.ps1') -Raw
$htmlSource = [System.IO.File]::ReadAllText((Join-Path $repositoryRoot 'index.html'))
$readme = [System.IO.File]::ReadAllText((Join-Path $repositoryRoot 'README.md'))

if ($serverSource -notmatch 'function Resolve-WikiPath') {
    $failures.Add('WebSV.ps1 must validate requested paths.')
}
if ($serverSource -notmatch '\[switch\]\$MarkdownOnly') {
    $failures.Add('Markdown file operations must be restricted to the doc folder.')
}
if ($serverSource -notmatch 'http://localhost:8000/') {
    $failures.Add('The default listener must remain localhost-only.')
}
if ($serverSource -match 'Join-Path \$PSScriptRoot \$RequestFileName') {
    $failures.Add('Untrusted request paths must not be joined without validation.')
}
if ($htmlSource -match 'alert\(FileName\)') {
    $failures.Add('The request debug alert must remain removed.')
}

$getPageNameCount = ([regex]::Matches($htmlSource, 'function\s+GetPageName\s*\(')).Count
if ($getPageNameCount -ne 1) {
    $failures.Add("index.html must define GetPageName exactly once; found $getPageNameCount.")
}

foreach ($heading in @('## 起動方法', '## セキュリティ上の注意', '## 制限事項', '## トラブルシューティング')) {
    if ($readme -notmatch [regex]::Escape($heading)) {
        $failures.Add("README is missing: $heading")
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host 'Repository validation passed.'
