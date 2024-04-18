#!/usr/bin/env bash

{ which drill > /dev/null && dig=drill; } || { which dig > /dev/null && dig=dig; } || { echo "error: dig was not found. Please install dnsutils."; exit 1; }

NAMESERVERS=$(cat /etc/resolv.conf | grep ^nameserver | cut -d " " -f 2 | sed 's/$/#[\/etc\/resolv.conf]/')

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
216.146.35.35#Dyn
216.146.36.36#Dyn
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
"

# Domains to test. Duplicated domains are ok
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
$dig +short +tries=1 +time=2 +stats @2a0d:2a00:1::1 www.google.com | grep 216.239.38.120 >/dev/null 2>&1
if [ $? = 0 ]; then
    hasipv6="true"
fi


# Check the provided argument
providerstotest=$PROVIDERSV4

if [ "x$1" = "xipv6" ]; then
    if [ "x$hasipv6" = "x" ]; then
        echo "error: IPv6 support not found. Unable to do the ipv6 test."; exit 2;
    fi
    providerstotest=$PROVIDERSV6

elif [ "x$1" = "xipv4" ]; then
    providerstotest=$PROVIDERSV4

elif [ "x$1" = "xall" ]; then
    if [ "x$hasipv6" = "x" ]; then
        providerstotest=$PROVIDERSV4
    else
        providerstotest="$PROVIDERSV4 $PROVIDERSV6"
    fi
else
    providerstotest=$PROVIDERSV4
fi


# Printing the output header
totaldomains=0
printf "\n%-21s %-21s" "" ""

for d in $DOMAINS2TEST; do
    totaldomains=$((totaldomains + 1))
    printf "%-8s" "test$totaldomains"
done

printf "%-8s" "Average"
echo ""


for p in $NAMESERVERS $providerstotest; do
    pip=${p%%#*}
    pname=${p##*#}
    ftime=0

    printf "%-21s %-21s" "$pname" "$pip"
    for d in $DOMAINS2TEST; do
        ttime=$($dig +tries=1 +time=2 +stats @$pip $d | grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2)
        if [ -z "$ttime" ]; then
            ttime=1000  # Time out of 1s = 1000ms
        elif [ "x$ttime" = "x0" ]; then
            ttime=1
        fi

        printf "%-8s" "$ttime ms"
        ftime=$((ftime + ttime))
    done
	
    avg=$((100 * ftime / totaldomains))
    avg_decimal=$((avg / 100))
    avg_remainder=$((avg % 100))
    printf "%d.%02d ms\n" $avg_decimal $avg_remainder

done

printf "\n"
exit 0;
