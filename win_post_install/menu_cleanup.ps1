# WINDOWS POST INSTALLATION SCRIPTS
# START MENU CLEAN-UP
# by diasdm

$menuclean = @(
    "7-Zip"
    "VideoLAN"
	"Notepad++"
	"Okular"
	)

Foreach ($item in $menuclean) {
    Remove-Item -Recurse -Include *$item* -Path "$env:AppData\Microsoft\Windows\Start Menu\"
	Remove-Item -Recurse -Include *$item* -Path "$env:ProgramData\Microsoft\Windows\Start Menu\"
}