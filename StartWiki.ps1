# Canonical launcher for MarkdownPSLocalServerWiki.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$serverScript = Join-Path $PSScriptRoot 'WebSV.ps1'
& $serverScript
