#!/bin/bash
# TEST A DNS SERVER LIST AGAINST A DOMANIN NAME
# by Diasdm

# EITHER PASS DOMAIN NAME AS ARGUMENT OR ASK FOR IT
domain=$1
[ -z $domain ] && read -p "DOMAIN NAME: " domain

dnslist="./dnslist"  # PATH TO DNS SERVER LIST

# QUERY FUNCTION USING DIG
query(){
        dig +timeout=1 +short "@$1" $2 A 2> /dev/null
}

# MAIN LOOP
for dnsserver in $(cat "$dnslist"); do
        result="OK"
        IPADD=$(query $dnsserver $domain)

        # AVOID TIMEOUT BIG RESPONSE
        echo $IPADD | grep -s -q "timed out" && { IPADD="Timeout" ; result="FAIL" ; }

        echo "$result   > Nameserver: $dnsserver - Domain: $domain - IP answer: $IPADD"
done
exit 0
