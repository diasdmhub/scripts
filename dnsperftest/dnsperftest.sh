#!/usr/bin/env bash
# Shell script to test the performance of the most popular DNS providers so you can test from your own location
# by diasdm

# Check for Dig binary
{ which dig > /dev/null && dig=dig; } || { echo "error: dig was not found. Please install dig."; exit 1; }

# Build a list of nameservers from this host
NAMESERVERS=$(grep '^nameserver' /etc/resolv.conf | cut -d ' ' -f 2 | sed 's/$/#[local_nameserver]/')

# IPv4 DNS providers
PROVIDERSV4="
94.140.14.140#AdGuard
94.140.14.141#AdGuard
223.5.5.5#Ali
223.6.6.6#Ali
208.67.222.2#CiscoOpenDNS
208.67.220.2#CiscoOpenDNS
185.228.168.168#CleanBrowsing
185.228.169.168#CleanBrowsing
1.1.1.1#CloudFlare
1.0.0.1#CloudFlare
8.26.56.26#Comodo
8.20.247.20#Comodo
76.76.2.0#ControlD
76.76.10.0#ControlD
185.222.222.222#DNS.SB
45.11.45.11#DNS.SB
119.29.29.29#DNSPod
119.28.28.28#DNSPod
54.174.40.213#DNSWatchGO
52.3.100.184#DNSWatchGO
216.146.35.35#OracleDyn
216.146.36.36#OracleDyn
80.80.80.80#Freenom
80.80.81.81#Freenom
8.8.8.8#Google
8.8.4.4#Google
74.82.42.42#HurricaneElectric
194.242.2.2#Mullvad
156.154.70.1#Neustar
156.154.71.1#Neustar
193.110.81.0#dns0.eu
185.253.5.0#dns0.eu
9.9.9.10#Quad9
149.112.112.10#Quad9
195.46.39.39#SafeDNS
195.46.39.40#SafeDNS
101.226.4.6#360SecureDNS
218.30.118.6#360SecureDNS
64.6.64.6#Verisign
64.6.65.6#Verisign
104.155.237.225#SafeSurfer
104.197.28.121#SafeSurfer
149.112.121.10#CIRACanadianShield
149.112.122.10#CIRACanadianShield
193.17.47.1#Comss.one
76.76.2.22#CZ.NICODVR
185.43.135.1#CZ.NICODVR
94.130.180.225#DNSforFamily
78.47.64.161#DNSforFamily
76.76.2.22#FondationRestena
114.114.114.114#114DNS
114.114.115.115#114DNS
88.198.92.222#LibreDNS
217.160.70.42#OpenNIC
101.101.101.101#Quad101
101.102.103.104#Quad101
77.88.8.8#Yandex
77.88.8.1#Yandex
5.2.75.75#AhaDNS
45.67.219.208#AhaDNS
176.9.93.198#DNSForge
176.9.1.117#DNSForge
45.54.76.1#deSEC.io
157.53.224.1#deSEC.org
"

# IPv6 DNS providers
PROVIDERSV6="
2606:4700:4700::1111#cloudflare-v6
2001:4860:4860::8888#google-v6
2620:fe::fe#quad9-v6
2620:119:35::35#opendns-v6
2a0d:2a00:1::1#cleanbrowsing-v6
2a02:6b8::feed:0ff#yandex-v6
2a00:5a60::ad1:0ff#adguard-v6
2610:a1:1018::3#neustar-v6
2607:f740:e633:deec::2#deSEC.io
2607:f740:e00a:deec::2#deSEC.org
"

# Domains to test against. Duplicated domains are ok
DOMAINS2TEST="
google.com
facebook.com
apple.com
microsoft.com
amazon.com
youtube.com
instagram.com
reddit.com
twitter.com
whatsapp.com
"

# Testing for IPv6 connectivity
if $dig +short +tries=1 +time=2 +stats @2607:f740:e633:deec::2 checkipv6.dedyn.io AAAA | grep -q -s '2a01:4f8:10a:1044:deec:642:ac10:80'; then
	hasipv6="true"
fi


# Check the provided argument
providerstotest=$PROVIDERSV4

if [ "$1" = "ipv6" ]; then
    if [ -z "$hasipv6" ]; then
        echo "error: IPv6 support not found. Unable to do an IPv6 test."; exit 2;
    fi
    providerstotest=$PROVIDERSV6

elif [ "$1" = "ipv4" ]; then
    providerstotest=$PROVIDERSV4

elif [ "$1" = "all" ]; then
    if [ -z "$hasipv6" ]; then
        providerstotest=$PROVIDERSV4
    else
        providerstotest="$PROVIDERSV4 $PROVIDERSV6"
    fi
else
    providerstotest=$PROVIDERSV4
fi


# Printing the output header
printf "\nDNS PROVIDER PERFORMANCE TEST\n"
printf "%-122s\n" "" | tr ' ' '-'
printf "| Provider %-9s | IP / Test >%-5s" "" ""

totaldomains=0
for d in $DOMAINS2TEST; do
    totaldomains=$((totaldomains + 1))
    printf "%-7s" "| $totaldomains"
done

printf "%-11s |\n" "| Average "
printf "%-122s\n" "" | tr ' ' '-'


# Testing providers
for p in $NAMESERVERS $providerstotest; do
    pip=${p%%#*}
    pname=${p##*#}
    total_time=0

    printf "| %-18s | %-16s" "$pname" "$pip"
    for d in $DOMAINS2TEST; do
        query_time=$($dig +tries=1 +time=2 +stats "@$pip" "$d" | grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2)
        if [ -z "$query_time" ]; then
            query_time=1000  # Time out of 1s = 1000ms
        elif [ "$query_time" = "0" ]; then
            query_time=1
        fi

        printf "| %4s " $query_time
        total_time=$((total_time + query_time))
    done
	
    avg=$((100 * total_time / totaldomains))
    avg_decimal=$((avg / 100))
    avg_remainder=$((avg % 100))
    printf "| %3d.%-02d ms |\n" $avg_decimal $avg_remainder
done

printf "%-122s\n\n" "" | tr ' ' '-'
exit 0;
