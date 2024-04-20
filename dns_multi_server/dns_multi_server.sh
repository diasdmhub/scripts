#!/bin/bash
# TEST A DNS SERVER LIST AGAINST A DOMAIN NAME
# by Diasdm
# Syntax: ./dns_multi_server.sh [domain] [dnslist path]

# EITHER PASS DOMAIN NAME AS ARGUMENT OR ASK FOR IT
echo -e "\n"
domain=$1
[ -z "$domain" ] && read -r -p "DOMAIN NAME: " domain

# PATH TO DNS SERVER LIST. IF NOT SET, USE DEFAULT
dnslist=$2
[ -z "$dnslist" ] && read -r -p "DNS LIST PATH (default = './dnslist'): " dnslist
[ -z "$dnslist" ] && dnslist="./dnslist"

# QUERY FUNCTION USING DIG
query(){
        dig +timeout=1 +short "@$1" "$2" A 2> /dev/null
}

# MAIN LOOP
echo -e "\n"
for dnsserver in $(cat "$dnslist"); do
        result="OK"
        IPADD=$(query "$dnsserver" "$domain")

        # AVOID TIMEOUT BIG RESPONSE
        echo "$IPADD" | grep -s -q "timed out" && { IPADD="Timeout" ; result="FAIL" ; }

        echo "$result   > Nameserver: $dnsserver - Domain: $domain - IP answer: $IPADD"
done
echo -e "\n"
exit 0
