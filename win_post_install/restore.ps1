# WINDOWS POST INSTALLATION SCRIPT
# RESTORE POING SETUP
# by diasdm

# STOP WINDOWS RESTORE AND DELETE ALL RESTORE POINTS
$drives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty Root
Get-ComputerRestorePoint
vssadmin delete shadows /all
Disable-ComputerRestore -Drive $drives