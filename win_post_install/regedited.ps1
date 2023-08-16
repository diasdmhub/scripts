# WINDOWS POST INSTALLATION SCRIPT
# Collection of simple system optimizations and functionalitys using the registry editor
# by diasdm

# Activate Num Lock at Windows logon
REG ADD "HKU\.DEFAULT\Control Panel\Keyboard"/v InitialKeyboardIndicators /t REG_SZ /d 2 /f

# Speed up the Start Menu
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 100 /f

# Change the DNS resolution priority
# LocalPriority = 499 default - local names cache - recommended 4
# HostPriority = 500 default - the HOSTS file - recommended 5
# DnsPriority = 2000 default - DNS host resolution - recommended 6
# NetbtPriority = 2001 default - NetBT name resolution - recommended 7
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v LocalPriority /t REG_DWORD /d 4 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v HostPriority /t REG_DWORD /d 5 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v DnsPriority /t REG_DWORD /d 6 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v NetbtPriority /t REG_DWORD /d 7 /f

# Disable telemetry
# https://learn.microsoft.com/en-us/windows/privacy/configure-windows-diagnostic-data-in-your-organization
# https://winaero.com/how-to-disable-telemetry-and-data-collection-in-windows-10
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

# Activate the logon/logoff system messages (verbose)
# https://learn.microsoft.com/en-us/troubleshoot/windows-server/performance/enable-verbose-startup-shutdown-logon-logoff-status-messages
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v verbosestatus /t REG_DWORD /d 1 /f

# Prefer IPv4 over IPv6 on Windows
# https://learn.microsoft.com/en-US/troubleshoot/windows-server/networking/configure-ipv6-in-windows
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 32 /f