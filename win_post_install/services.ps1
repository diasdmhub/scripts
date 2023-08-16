# WINDOWS POST INSTALLATION SCRIPT
# SERVICES SETUP
# by diasdm


# 001.000 STOP AND DISABLE UNECESSARY SERVICES

# 001.001 LIST FOR DISABLED SERVICE
$DisabledList = @(
        'DiagTrack',     # Connected User Experiences and Telemetry (Disabled)
        'lfsvc',         # Geolocation Service (Disabled)
        'TrkWks',        # Distributed Link Tracking Client (Disabled)
        'CscService',    # Offline Files (Disabled)
        'WebClient',     # WebClient (Disabled)
        'WMPNetworkSvc'  # Windows Media Player Network Sharing Service (Disabled)
        'WpnService'     # Windows Push Notifications System Service (Disabled)
        'WerSvc'         # Windows Error Reporting Service (Disabled)
        'WbioSrvc'       # Windows Biometric Service (Disabled)
        )

# 001.002 LIST FOR MANUAL SERVICE
$ManualList = @(
        'lmhosts',               # TCP/IP NetBIOS Helper (Manual)
        'wuauserv'               # Windows Update (Manual)
        )

# 001.003 CONCATENATE LISTS
$FullList = $DisabledList + $ManualList


# 002.000 STOP SERVICE
Write-Host "`nSTOPPING SERVICE"

# 002.001 STOP ALL SERVICES
for($i=0; $i -lt $FullList.Count; $i++){
        Stop-Service -ErrorAction SilentlyContinue -PassThru -Force -Name $FullList[$i]
}


# 003.000 SET SERVICE STARTUP TYPE
Write-Host "`n`nSETTING SERVICE STARTUP TYPE`n"

# 003.001 SET DISABLED STARTUP TYPE
for($i=0; $i -lt $DisabledList.Count; $i++){
        Set-Service -ErrorAction SilentlyContinue -PassThru -StartupType Disabled -Name $DisabledList[$i]
}

# 003.002 SET MANUAL STARTUP TYPE
for($i=0; $i -lt $ManualList.Count; $i++){
        Set-Service -ErrorAction SilentlyContinue -PassThru -StartupType Manual -Name $ManualList[$i]
}