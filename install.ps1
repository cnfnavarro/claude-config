# Enlaza claude-config\agents como ~\.claude\agents (junction, sin admin).
$ErrorActionPreference = 'Stop'
$repoAgents = Join-Path $PSScriptRoot 'agents'
$claudeDir  = Join-Path $env:USERPROFILE '.claude'
$link       = Join-Path $claudeDir 'agents'

if (-not (Test-Path $repoAgents)) { throw "No existe $repoAgents" }
if (-not (Test-Path $claudeDir))  { New-Item -ItemType Directory -Path $claudeDir | Out-Null }

if (Test-Path $link) {
    $item = Get-Item $link -Force
    if ($item.LinkType -eq 'Junction' -and ($item.Target -contains $repoAgents)) {
        Write-Host "Ya enlazado: $link -> $repoAgents"; return
    }
    $bak = "$link.bak-$(Get-Date -Format yyyyMMdd-HHmmss)"
    Rename-Item $link $bak
    Write-Host "Carpeta existente movida a $bak"
}

New-Item -ItemType Junction -Path $link -Target $repoAgents | Out-Null
Write-Host "Enlazado: $link -> $repoAgents"
