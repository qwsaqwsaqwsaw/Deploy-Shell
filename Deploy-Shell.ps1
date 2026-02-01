# =========================================================================
# Project: Universal Shell Engine (USE) v1.0.0
# Deployment: Session-Specific HKCU Redirection
# License: MIT
# =========================================================================

$AppExeName = "steam.exe"
$AppArgs    = "-bigpicture"
$EngineDir  = "$env:ProgramData\ShellEngine"
$LogFile    = "$EngineDir\engine.log"
$RegPath    = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"

# 1. Environment Preparation
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Administrative privileges required."; exit 1
}
if (!(Test-Path $EngineDir)) { New-Item -Path $EngineDir -ItemType Directory -Force | Out-Null }

# 2. Executable Path Resolution
$AppPath = (Get-Command $AppExeName -ErrorAction SilentlyContinue).Source
if (-not $AppPath) {
    $Drives = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -gt 0 }
    foreach ($Drive in $Drives) {
        $AppPath = Get-ChildItem -Path "$($Drive.Root)" -Include $AppExeName -File -Recurse -Depth 3 -EA SilentlyContinue | Select-Object -ExpandProperty FullName -First 1
        if ($AppPath) { break }
    }
}

if (-not $AppPath) { Write-Error "Target executable not found."; exit 1 }

# 3. Boot Manager Generation (Runtime Logic)
$BootScript = Join-Path $EngineDir "BootManager.ps1"
$BootContent = @"
`$Time = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
"[`$Time] [INFO] Target Execution: $AppPath" | Out-File -FilePath '$LogFile' -Append
try {
    if (!(Get-Process 'ctfmon' -EA SilentlyContinue)) { Start-Process 'C:\Windows\System32\ctfmon.exe' }
    Start-Process '$AppPath' -ArgumentList '$AppArgs' -Wait
} catch {
    "[`$Time] [ERROR] Exception: `$(`$_.Exception.Message)" | Out-File -FilePath '$LogFile' -Append
} finally {
    Start-Process 'explorer.exe'
}
"@
Set-Content -Path $BootScript -Value $BootContent -Encoding UTF8

# 4. Adaptive Rollback Script Generation
$UninstallPath = Join-Path $env:USERPROFILE "Desktop\Restore_Explorer.ps1"
$UninstallContent = @"
Write-Host "Reverting to standard Explorer shell..." -ForegroundColor Cyan
Remove-ItemProperty -Path '$RegPath' -Name "Shell" -Force -ErrorAction SilentlyContinue
Write-Host "System restart recommended." -ForegroundColor Yellow
pause
"@
Set-Content -Path $UninstallPath -Value $UninstallContent -Encoding UTF8

# 5. Registry Injection (Shell Redirection)
if (!(Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }
$ShellCmd = "powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$BootScript`""
Set-ItemProperty -Path $RegPath -Name "Shell" -Value $ShellCmd -Force

# 6. Post-Deployment Reboot Sequence
Write-Host "Deployment successful. Session Rollback tool created on Desktop." -ForegroundColor Green
$Choice = Read-Host "System reboot is required to apply the new Shell. Restart now? (Y/N)"
if ($Choice -eq "Y" -or $Choice -eq "y") {
    Restart-Computer -Force
}
