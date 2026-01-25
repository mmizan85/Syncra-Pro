<#
.SYNOPSIS
    Syncra Automated Installer Script
.DESCRIPTION
    1. Sets System PATH for 'bin' folder.
    2. Creates a Desktop Launcher (.bat) for the Agent.
    3. Captures User Download Path to 'download_path.txt'.
    4. Opens Chrome & Copies Extension Path to Clipboard.
#>

# (Admin Rights)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Requesting Admin Privileges..." -ForegroundColor Yellow
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}


Clear-Host
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "           SYNCRA SYSTEM INSTALLER (PowerShell)" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host ""


$ScriptPath = $PSScriptRoot
$BinPath = Join-Path $ScriptPath "bin"
$AgenPath = Join-Path $ScriptPath "agen"
$ExtPath = Join-Path $ScriptPath "extension"
$ConfigPath = Join-Path $AgenPath "download_path.txt"

# ---------------------------------------------------
# 
# ---------------------------------------------------
Write-Host "[1/4] Configuring System Environment Paths..." -ForegroundColor Yellow


$CurrentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

if ($CurrentPath -notlike "*$BinPath*") {
    $NewPath = $CurrentPath + ";" + $BinPath
    [Environment]::SetEnvironmentVariable("Path", $NewPath, "Machine")
    Write-Host "[Ok] Bin path added to System Environment." -ForegroundColor Green
} else {
    Write-Host "[!] Path already exists. Skipping." -ForegroundColor Gray
}
Write-Host ""

# ---------------------------------------------------
# 
# ---------------------------------------------------
Write-Host "[2/4] Creating Desktop Launcher..." -ForegroundColor Yellow

$DesktopDir = [Environment]::GetFolderPath("Desktop")
$BatFilePath = Join-Path $DesktopDir "Run Syncra.bat"

# 
$BatContent = @(
"@echo off",
"TITLE Syncra Server",
"cd /d `"$AgenPath`"",
"echo Starting Syncra Agent...",
"powershell -ExecutionPolicy Bypass -File `"SyncraAgent.ps1`"",
"pause"
)


Set-Content -Path $BatFilePath -Value $BatContent
Write-Host "[Ok] Launcher created at: $BatFilePath" -ForegroundColor Green
Write-Host ""

# ---------------------------------------------------
# 
# ---------------------------------------------------
Write-Host "[3/4] Setup Download Directory" -ForegroundColor Yellow
Write-Host "Please enter the folder path where you want to save videos."
Write-Host "(Example: D:\Movies or C:\Users\Name\Downloads)" -ForegroundColor Gray
Write-Host "If you do not provide a path, if will be saved directly to the Windows Downloads folder." -ForegroundColor Gray

$UserDownloadPath = Read-Host -Prompt "Enter Path"

if ([string]::IsNullOrWhiteSpace($UserDownloadPath)) {
    Write-Host "[X] Error: No path entered. Defaulting to script folder." -ForegroundColor Red
    $UserDownloadPath = $AgenPath
}


Set-Content -Path $ConfigPath -Value $UserDownloadPath
Write-Host "[Ok] Saved download path to config file." -ForegroundColor Green
Write-Host ""

# ---------------------------------------------------
# 
# ---------------------------------------------------
Write-Host "[4/4] Launching Chrome & Copying Path..." -ForegroundColor Yellow


Set-Clipboard -Value $ExtPath
Write-Host "[Ok] Extension folder path copied to Clipboard!" -ForegroundColor Green


Start-Process "chrome.exe" "chrome://extensions/"

Write-Host ""
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "           INSTALLATION COMPLETE!" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Action Required:" -ForegroundColor Yellow
Write-Host "1. In Chrome, enable 'Developer Mode'."
Write-Host "2. Click 'Load unpacked'."
Write-Host "3. Paste (Ctrl+V) the path in the file selector window."
Write-Host ""
Write-Host "Press Enter to exit..."
Read-Host
