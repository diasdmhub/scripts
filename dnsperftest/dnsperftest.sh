#!/usr/bin/env bash

{ which drill > /dev/null && dig=drill; } || { which dig > /dev/null && dig=dig; } || { echo "error: dig was not found. Please install dnsutils."; exit 1; }

NAMESERVERS=$(cat /etc/resolv.conf | grep ^nameserver | cut -d " " -f 2 | sed 's/$/#[\/etc\/resolv.conf]/')

# IPv4 DNS providers
PROVIDERSV4="
1.1.1.1#cloudflare
4.2.2.1#level3
8.8.8.8#google
9.9.9.9#quad9
80.80.80.80#freenom
208.67.222.123#opendns
199.85.126.20#norton
185.228.168.168#cleanbrowsing
77.88.8.7#yandex
176.103.130.132#adguard
156.154.70.3#neustar
8.26.56.26#comodo
45.90.28.202#nextdns
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
www.google.com
amazon.com
facebook.com
www.youtube.com
www.reddit.com
wikipedia.org
twitter.com
gmail.com
www.google.com
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

exit 0;
