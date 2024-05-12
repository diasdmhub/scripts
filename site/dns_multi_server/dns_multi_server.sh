#!/bin/bash
# QUERY A DOMAIN NAME IPv4 FROM A DNS SERVER LIST
# by Diasdm
# Syntax: ./dns_multi_server.sh [domain] [dnslist path]

# EITHER PASS DOMAIN NAME AS ARGUMENT OR ASK FOR IT
printf "\n"
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

# HEADER
printf "\n"
printf "|-----------------------------------------------------------------|\n"
printf "| Domain: %-56s|\n" "$domain"
printf "|--------|-----------------|--------------------------------------|\n"
printf "| RESULT |   AWNSWER       |              NAMESERVER              |\n"
printf "|--------|-----------------|--------------------------------------|\n"

# MAIN LOOP
for dnsserver in $(cat "$dnslist"); do
	result="OK"
	serverip=${dnsserver%%#*}
	servername=${dnsserver##*#}

	DADD=$(query "$serverip" "$domain")

	# AVOID TIMEOUT BIG RESPONSE
	echo "$DADD" | grep -s -q "timed out" && { DADD="Timeout" ; result="FAIL" ; }

	printf "| %-6s | %-15s | %-15s - %-18s |\n" "$result" "$DADD" "$serverip" "$servername"
done

printf "|--------|-----------------|--------------------------------------|\n\n"
exit 0
