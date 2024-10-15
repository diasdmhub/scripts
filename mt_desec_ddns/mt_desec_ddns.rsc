#---------- INFORMATION -----------------------------
#
# Script.: deSEC DDNS update script for RouterOS
# Version: 2
# Created: 27/04/2024
# Author.: diasdm
# Source.: https://github.com/diasdmhub/scripts
#
#--------- MODIFY THE NEXT VALUES AS NEEDED ---------

# deSEC domain
:local desecDomain "## YOUR DOMAIN NAME ##"

# deSEC DNS Token
:local desecToken "## DESEC TOKEN ##"

# WAN interface name
:local wanInterface "## YOUR WAN INTERFACE ##"

# deSEC update URL
:local desecUpdateUrl "https://update.dedyn.io"

# deSEC online service that returns your IPv4
#:local ipv4DetectService "https://checkipv4.dedyn.io"

# deSEC online service that returns your IPv6
#:local ipv6DetectService "https://checkipv6.dedyn.io"

#----------------------------------------------------

# Variable set
:local domainIPv4
:local currentIPv4
:local domainIPv6
:local currentIPv6

# Function to validate the WAN interface
:global validadeInt do={
    :local ifInt [:tostr $1]
    :if ([:len [/interface/find where name=$ifInt]] != 1) do={
	    :return "Interface > $ifInt < does not exist"
	}
    /; :return true
}

# Function to capture the public IPv4 address from the WAN interface
:global getWanIpv4 do={
    :local ifIPv4 [:tostr $inter]
    /ip address
    :if ([:len [find where interface=$ifIPv4]] > 1) do={
	    :return "Interface -> $ifIPv4 <- has more than one address"
	}
    :local ifAdd [get number=[find where interface=$ifIPv4] value-name=address]
    :return [:toip [:pick $ifAdd 0 [:find $ifAdd "/" -1]]]
}

# Function to capture the public IPv6 adress from the WAN interface
:global getWanIpv6 do={
    :local ifIPv6 [:tostr $inter]
    /ipv6 address
#    :if ([:len [find where interface=$ifIPv6 global address]] > 1) do={
#	    :return "Interface -> $ifIPv6 <- has more than one global address"
#	}
# Using pick to select only the first available IPv6 global address
    :local ifAdd [get number=[:pick [find where interface=$ifIPv6 global address] 0 1] value-name=address]
    :return [:toip6 [:pick $ifAdd 0 [:find $ifAdd "/" -1]]]
}


#:log info message="deSEC DDNS: dedyn.io DDNS Update START"

# Validate WAN interface
:local valInt [$validadeInt $wanInterface]
:if ($valInt != true) do={
    :log error message="deSEC DDNS: Failed WAN interface -> $valInt"
    :error "deSEC DDNS: Failed WAN interface -> $valInt"
}

# Resolve current deSEC domain ip address
:do {
    :set domainIPv4 [:resolve domain-name=$desecDomain]
} on-error={
    :log error message="deSEC DDNS: Failure to resolve IPv4 DNS domain \"$desecDomain\""
    :error "deSEC DDNS: Failure to resolve IPv4 DNS domain \"$desecDomain\""
}

# Get current IPv4 from the WAN interface
:set currentIPv4 [$getWanIpv4 inter=$wanInterface]
:if ([:type $currentIPv4] != "ip") do={
    :log error message="deSEC DDNS: Failed to get WAN IPv4 -> $currentIPv4"
    :error "deSEC DDNS: Failed to get WAN IPv4 -> $currentIPv4"
}

# Get current IPv6 from the WAN interface
:set currentIPv6 [$getWanIpv6 inter=$wanInterface]
:if ([:type $currentIPv6] != "ip6") do={
    :log error message="deSEC DDNS: Failed to get WAN IPv6 -> $currentIPv6"
	:error "deSEC DDNS: Failed to get WAN IPv6 -> $currentIPv6"
}

# Send new IP if the domain is not updated
:if ($currentIPv4 != $domainIPv4) do={
    :log warning message="deSEC DDNS: \"$desecDomain\" IPv4 ($domainIPv4) differs from current WAN IPv4 ($currentIPv4) - Sending update"

    :local desecResponse
    :local desecRequestURL "$desecUpdateUrl/?hostname=$desecDomain&myipv4=$currentIPv4&myipv6=$currentIPv6"

    :retry delay=10 max=2 command={
        :set desecResponse [/tool fetch url=$desecRequestURL mode=https http-header-field="Authorization: Token $desecToken" output=user as-value]
    } on-error={
        :log error message="deSEC DDNS: Failed twice to send GET request to the deSEC server."
        :error "deSEC DDNS: Failed twice to send GET request to the deSEC server."
    }

# Validating response
    :if ($desecResponse->"data" = "good") do={
        :log info message="deSEC DDNS: \"$desecDomain\" updated successfully to $currentIPv4 - $currentIPv6"
    } else={
        :log warning message="deSEC DDNS: \"$desecDomain\" update unknown. deSEC did not respond with \"good\""
    }

# Stop if the WAN IP is the same as the domain IP
} else={
    :log info message="deSEC DDNS: \"$desecDomain\" IPv4 ($domainIPv4) equals to current WAN IPv4 ($currentIPv4) - Update not required"
}

#:log info message="deSEC DDNS: dedyn.io DDNS Update END"
