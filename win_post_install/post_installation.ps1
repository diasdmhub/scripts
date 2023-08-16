# WINDOWS POST INSTALLATION SCRIPTS
# by diasdm

# Check and start as Administrator
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "The script was not started as an Administrator. It will self elevate."
    Start-Sleep 3
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

Write-Host "`n`n# RESTORE POING SETUP`n"
. "$PSScriptRoot\restore.ps1"

Write-Host "`n`n# REMOVE DEFAULT BLOATWARE APPLICATIONS`n"
. "$PSScriptRoot\bloatware.ps1"

Write-Host "`n`n# SERVICES SETUP`n"
. "$PSScriptRoot\services.ps1"

Write-Host "`n`n# REGISTRY SYSTEM OPTIMIZATIONS`n"
. "$PSScriptRoot\regedited.ps1"

Write-Host "`n`n# BASIC APPS INSTALLATION`n"
. "$PSScriptRoot\apps_install.ps1"

Write-Host "`n`n# START MENU CLEAN-UP`n"
. "$PSScriptRoot\menu_cleanup.ps1"

Write-Host "`n`n# FINISHED`n"
Read-Host -Prompt "Press any key to close"
