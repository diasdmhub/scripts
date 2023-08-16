# WINDOWS POST INSTALLATION SCRIPTS
# BASIC APPS INSTALLATION
# by diasdm

Write-Host "`n`nUPDATE WIN STORE FIRST`n"
Read-Host -Prompt "Press any key to close"

winget update -r

Write-Host "`n`n7-Zip`n"
# https://www.7-zip.org
winget install 7zip.7zip --accept-source-agreements

Write-Host "`n`nNotepad++`n"
# https://notepad-plus-plus.org
winget install Notepad++.Notepad++ --accept-source-agreements

Write-Host "`n`Okular PDF`n"
# https://okular.kde.org
winget install KDE.Okular --accept-source-agreements

Write-Host "`n`VLC`n"
# https://www.videolan.org
winget install VideoLAN.VLC --accept-source-agreements

Write-Host "`n`Firefox`n"
# https://www.videolan.org
winget install Mozilla.Firefox --accept-source-agreements