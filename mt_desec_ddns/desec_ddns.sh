#!/bin/bash
#---------- INFORMATION ------------------------------
#
# Script.: deSEC DDNS update script for AsusWRT Router
# Version: 1
# Created: 12/04/2024
# Author.: diasdm
# Source.: https://github.com/diasdmhub/scripts
#
#--------- MODIFY THE NEXT VALUES AS NEEDED ----------

# deSEC domain
desecDomain="## YOUR DOMAIN NAME ##"

# deSEC DNS Token
desecToken="## DESEC TOKEN ##"

# WAN interface name
wanInterface="## YOUR WAN INTERFACE ##"

# deSEC update URL
desecUpdateUrl="https://update.dedyn.io"

# deSEC online service that returns your IPv4
#ipv4DetectService="https://checkipv4.dedyn.io"

# deSEC online service that returns your IPv6
#ipv6DetectService="https://checkipv6.dedyn.io"

#-----------------------------------------------------

# Function to write log into syslog
function log_write {
    logger -t "deSEC DDNS" "$1"
}

# Function to validate the WAN interface
function validadeInt {
    ifInt=$1
    if ip link show "$ifInt" &>/dev/null; then
        return 0
    else 
        return 1
    fi
}

# Function to capture the public IPv4 address from the WAN interface
function getWanIpv4 {
    ifIPv4=$1
    ifAdd=$(ip -o -4 addr show dev "$ifIPv4" scope global | awk '{split($4,a,"/"); print a[1]}')
    echo "$ifAdd"
}

# Function to capture the public IPv6 adress from the WAN interface
function getWanIpv6 {
    ifIPv6=$1
    ifAdd=$(ip -o -6 addr show dev "$ifIPv6" scope global | awk '{split($4,a,"/"); print a[1]}')
    echo "$ifAdd"
}

# Function to send IP update to deSEC.io
function updateIp {
    desecRequestURL="$desecUpdateUrl/?hostname=$desecDomain&myipv4=$currentIPv4&myipv6=$currentIPv6"
    curl -s \
         -w "%{http_code}" \
         -X GET \
         -H "Authorization: Token $desecToken" \
         "$desecRequestURL"
}

# Validate WAN interface
if ! validadeInt "$wanInterface"; then
    log_write "WAN interface > $wanInterface < does not exist"
    exit 1
fi

# Resolve current deSEC domain IPv4 address
domainIPv4=$(dig -t A +short "$desecDomain")
if [ -z "$domainIPv4" ]; then
    log_write "Failed to resolve IPv4 DNS domain \"$desecDomain\""
    exit 2
fi

# Resolve current deSEC domain IPv6 address
domainIPv6=$(dig -t AAAA +short "$desecDomain")
if [ -z "$domainIPv6" ]; then
    log_write "Failed to resolve IPv6 DNS domain \"$desecDomain\""
    exit 3
fi

# Get current IPv4 from the WAN interface
currentIPv4=$(getWanIpv4 "$wanInterface")
if [ -z "$currentIPv4" ]; then
    log_write "Failed to get IPv4 from WAN interface -> $wanInterface"
    exit 4
fi

# Get current IPv6 from the WAN interface
currentIPv6=$(getWanIpv6 "$wanInterface")
if [ -z "$currentIPv6" ]; then
    log_write "Failed to get IPv6 from WAN interface -> $wanInterface"
    exit 5
fi


# Update to a new IP if the domain is not updated
updateYes=0
if [ "$currentIPv4" != "$domainIPv4" ]; then
    log_write "\"$desecDomain\" IPv4 ($domainIPv4) differs from current WAN IPv4 ($currentIPv4) - Sending update"
    updateYes=1

# Only check IPv6 if IPv4 has not changed
else
    if [ "$currentIPv6" != "$domainIPv6" ]; then
        log_write "\"$desecDomain\" IPv6 ($domainIPv6) differs from current WAN IPv6 ($currentIPv6) - Sending update"
        updateYes=1
    else

# Does nothing if the WAN IP is the same as the domain IP
        log_write "\"$desecDomain\" domain IP equals to current WAN IP - Update not required"
    fi
fi

if [ $updateYes -eq 1 ]; then
    desecResponse=$(updateIp)
    desecString="${desecResponse%???}"
    desecHttpCode=$(printf '%s' "$desecResponse" | tail -c 3)

# Validating response
    if [ "$desecString" == "good" ]; then
        log_write "\"$desecDomain\" updated successfully to $currentIPv4 - $currentIPv6"
    else
        log_write "\"$desecDomain\" update failed. deSEC did not respond with \"good\". HTTP code \"$desecHttpCode\""
    fi
fi

exit
