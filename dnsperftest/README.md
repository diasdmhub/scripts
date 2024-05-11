<h1 align="center">DNS Performance Test</h1>
<p align="center">
  <b>Shell script to test the performance of the most popular DNS providers so you can test from your own location</b>
</p>

<BR>

## DOWNLOAD
[▶️ dnsperftest.sh](./dnsperftest.sh)

<BR>

## DEFAULT DNS LIST

- ✅ The list is based on the [**AdGuard DNS providers list**](https://adguard-dns.io/kb/general/dns-providers).
- ℹ️ **It is recommended that you change this list to reflect your preferred providers.**

| IPv4 DNS Provider   | IP 1             | IP 2             | Filter* | Log* |
| ------------------- | :--------------: | :--------------: | :-----: | :--: |
| AdGuard             | 94.140.14.140    | 94.140.14.141    | No      | Yes  |
| Ali                 | 223.5.5.5        | 223.6.6.6        | Yes     | Yes  |
| BebasDNS            | 103.87.68.193    | -                | No      | No   |
| Cisco OpenDNS       | 208.67.222.2     | 208.67.220.2     | Yes     | Yes  |
| CleanBrowsing       | 185.228.168.168  | 185.228.169.168  | Yes     | Yes  |
| CloudFlare          | 1.1.1.1          | 1.0.0.1          | No      | Yes  |
| Comodo              | 8.26.56.26       | 8.20.247.20      | Yes     | Yes  |
| ControlD            | 76.76.2.0        | 76.76.10.0       | No      | Yes  |
| DNS.SB              | 185.222.222.222  | 45.11.45.11      | No      | No   |
| DNSPod              | 119.29.29.29     | 119.28.28.28     | Yes     | Yes  |
| DNSWatchGO          | 54.174.40.213    | 52.3.100.184     | Yes     | Yes  |
| Dyn                 | 216.146.35.35    | 216.146.36.36    | Yes     | Yes  |
| Freenom             | 80.80.80.80      | 80.80.81.81      | Yes     | No   |
| Google              | 8.8.8.8          | 8.8.4.4          | No      | Yes  |
| Hurricane Electric  | 74.82.42.42      | -                | Yes     | Yes  |
| Mullvad             | 194.242.2.2      | -                | No      | Yes  |
| Neustar             | 156.154.70.1     | 156.154.71.1     | No      | Yes  |
| dns0.eu             | 193.110.81.0     | 185.253.5.0      | Yes     | Yes  |
| Quad9               | 9.9.9.10         | 149.112.112.10   | No      | Yes  |
| Safe DNS            | 195.46.39.39     | 195.46.39.40     | Yes     | Yes  |
| 360 Secure DNS      | 101.226.4.6      | 218.30.118.6     | Yes     | Yes  |
| Verisign            | 64.6.64.6        | 64.6.65.6        | Yes     | Yes  |
| Safe Surfer         | 104.155.237.225  | 104.197.28.121   | Yes     | Yes  |
| CIRA Canadian Shield| 149.112.121.10   | 149.112.122.10   | No      | Yes  |
| Comss.one           | 193.17.47.1      | -                | Yes     | Yes  |
| CZ.NIC ODVR         | 76.76.2.22       | 185.43.135.1     | No      | No   |
| DNS for Family      | 94.130.180.225   | 78.47.64.161     | Yes     | Yes  |
| Fondation Restena   | 76.76.2.22       | -                | No      | Yes  |
| 114DNS              | 114.114.114.114  | 114.114.115.115  | Yes     | Yes  |
| LibreDNS            | 88.198.92.222    | -                | No      | Yes  |
| OpenNIC DNS         | 217.160.70.42    | -                | No      | Yes  |
| Quad101             | 101.101.101.101  | 101.102.103.104  | No      | No   |
| Yandex              | 77.88.8.8        | 77.88.8.1        | No      | Yes  |
| AhaDNS              | 5.2.75.75        | 45.67.219.208    | Yes     | No   |
| DNS Forge           | 176.9.93.198     | 176.9.1.117      | Yes     | No   |

> _This is a manual list and may not be accurate. <br>
> There may be regional providers that are not accessible from everywhere. <br>
> Also, the DNS IP of the provider may change depending on the region. <br>
> \* These are allegedly non-filtering and non-logging providers. <br>
> \* It is considered Yes if not stated otherwise._

<BR>

## DEFAULT DOMAIN LIST

- ✅ This list is based on some of the top domains from [**Cloudflare Domain Rankings**](https://radar.cloudflare.com/domains)
- ✅ It is used for testing the DNS providers.

| Domain |
| :---: |
| google.com |
| facebook.com |
| apple.com |
| microsoft.com
| amazon.com |
| youtube.com |
| instagram.com |
| reddit.com |
| twitter.com |
| whatsapp.com |

<BR>

## REQUIREMENTS

- ⛏️ **`Dig`** tool
    - If using **APT**: `apt install dnsutils`
    - If using **YUM / DNF**: `dnf install bind-utils`
    - If using **APK**: `apk add bind-tools`
    - If using **PACMAN**: `pacman -S bind-tools`

<BR>

## SYNTAX

```bash
$ ./dnsperftest.sh [IP version]
```

**`[IP version]`:** <br>
🔹 **`ipv4`** - _(default)_ For IPv4 addresses only

🔹 **`ipv6`** - For IPv6 addresses only

🔹 **`all`** - For IPv4 and IPv6 addresses

<BR>

## UTILIZATION

**1\.** Download the script and save it on your test system.
```
wget -q https://raw.githubusercontent.com/diasdmhub/scripts/master/dnsperftest/dnsperftest.sh
```

**2\.** Give the script execution permission.
```
chmox +x dnsperftest.sh
```

**3\.** Run the script. If no arguments are given, it uses `ipv4` as the default argument.
```
./dnsperftest.sh
```

> **You can sort the result by piping it to `sort` as in the example below.**

<BR>

## EXAMPLE
```
# /jffs/scripts/dnsperftest.sh | sort -k 23 -n

                                           test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average
SafeDNS               195.46.39.40         18 ms   18 ms   17 ms   17 ms   16 ms   18 ms   18 ms   17 ms   18 ms   17 ms   17.40 ms
Neustar               156.154.70.1         16 ms   17 ms   18 ms   19 ms   18 ms   18 ms   17 ms   18 ms   17 ms   21 ms   17.90 ms
Verisign              64.6.64.6            18 ms   20 ms   19 ms   17 ms   19 ms   19 ms   17 ms   19 ms   16 ms   19 ms   18.30 ms
Dyn                   216.146.36.36        19 ms   18 ms   18 ms   17 ms   19 ms   18 ms   20 ms   22 ms   17 ms   20 ms   18.80 ms
CloudFlare            1.1.1.1              19 ms   16 ms   21 ms   17 ms   22 ms   20 ms   20 ms   17 ms   19 ms   20 ms   19.10 ms
AdGuard               94.140.14.141        21 ms   18 ms   20 ms   21 ms   20 ms   19 ms   18 ms   17 ms   21 ms   17 ms   19.20 ms
Neustar               156.154.71.1         19 ms   17 ms   19 ms   19 ms   19 ms   18 ms   21 ms   21 ms   21 ms   18 ms   19.20 ms
Verisign              64.6.65.6            18 ms   18 ms   21 ms   19 ms   19 ms   23 ms   21 ms   22 ms   21 ms   21 ms   20.30 ms
CloudFlare            1.0.0.1              21 ms   19 ms   21 ms   20 ms   16 ms   26 ms   25 ms   21 ms   19 ms   19 ms   20.70 ms
CleanBrowsing         185.228.168.168      19 ms   20 ms   28 ms   21 ms   19 ms   20 ms   20 ms   21 ms   20 ms   20 ms   20.80 ms
ControlD              76.76.10.0           23 ms   20 ms   32 ms   19 ms   21 ms   21 ms   21 ms   21 ms   21 ms   22 ms   22.10 ms
ControlD              76.76.2.0            21 ms   22 ms   25 ms   22 ms   22 ms   22 ms   24 ms   22 ms   21 ms   23 ms   22.40 ms
FondationRestena      76.76.2.22           138 ms  20 ms   17 ms   21 ms   18 ms   20 ms   17 ms   18 ms   17 ms   18 ms   30.40 ms
Quad9                 9.9.9.10             18 ms   68 ms   47 ms   32 ms   17 ms   19 ms   21 ms   73 ms   20 ms   18 ms   33.30 ms
CZ.NICODVR            76.76.2.22           137 ms  17 ms   21 ms   18 ms   19 ms   20 ms   17 ms   70 ms   19 ms   24 ms   36.20 ms
CiscoOpenDNS          208.67.222.2         22 ms   17 ms   23 ms   129 ms  21 ms   19 ms   19 ms   71 ms   21 ms   20 ms   36.20 ms
Google                8.8.4.4              19 ms   20 ms   24 ms   20 ms   21 ms   135 ms  17 ms   67 ms   23 ms   23 ms   36.90 ms
SafeDNS               195.46.39.39         17 ms   19 ms   19 ms   19 ms   25 ms   20 ms   16 ms   135 ms  18 ms   140 ms  42.80 ms
Quad9                 149.112.112.10       17 ms   258 ms  19 ms   33 ms   20 ms   20 ms   31 ms   19 ms   18 ms   16 ms   45.10 ms
[/etc/resolv.conf]    127.0.0.1            1 ms    64 ms   128 ms  64 ms   24 ms   23 ms   67 ms   76 ms   1 ms    24 ms   47.20 ms
CiscoOpenDNS          208.67.220.2         75 ms   18 ms   23 ms   124 ms  19 ms   22 ms   21 ms   76 ms   72 ms   26 ms   47.60 ms
Dyn                   216.146.35.35        19 ms   18 ms   17 ms   16 ms   1000 ms 17 ms   17 ms   132 ms  17 ms   19 ms   127.20 ms
AdGuard               94.140.14.140        17 ms   21 ms   480 ms  21 ms   668 ms  19 ms   19 ms   19 ms   22 ms   23 ms   130.90 ms
CleanBrowsing         185.228.169.168      135 ms  139 ms  132 ms  130 ms  129 ms  129 ms  134 ms  132 ms  134 ms  136 ms  133.00 ms
HurricaneElectric     74.82.42.42          130 ms  130 ms  154 ms  127 ms  132 ms  129 ms  128 ms  143 ms  136 ms  133 ms  134.20 ms
Ali                   223.6.6.6            139 ms  141 ms  144 ms  145 ms  142 ms  141 ms  142 ms  143 ms  147 ms  146 ms  143.00 ms
Comodo                8.26.56.26           158 ms  128 ms  158 ms  129 ms  130 ms  160 ms  163 ms  130 ms  136 ms  156 ms  144.80 ms
Ali                   223.5.5.5            147 ms  148 ms  140 ms  145 ms  143 ms  148 ms  144 ms  145 ms  144 ms  150 ms  145.40 ms
Comodo                8.20.247.20          159 ms  131 ms  131 ms  131 ms  160 ms  132 ms  157 ms  154 ms  164 ms  141 ms  146.00 ms
CIRACanadianShield    149.112.122.10       152 ms  152 ms  158 ms  153 ms  154 ms  149 ms  155 ms  151 ms  151 ms  153 ms  152.80 ms
SafeSurfer            104.197.28.121       154 ms  151 ms  156 ms  158 ms  154 ms  151 ms  157 ms  155 ms  160 ms  151 ms  154.70 ms
DNSWatchGO            52.3.100.184         159 ms  153 ms  156 ms  160 ms  154 ms  159 ms  151 ms  157 ms  160 ms  161 ms  157.00 ms
CIRACanadianShield    149.112.121.10       164 ms  161 ms  156 ms  154 ms  154 ms  163 ms  155 ms  160 ms  156 ms  155 ms  157.80 ms
DNSWatchGO            54.174.40.213        160 ms  162 ms  160 ms  162 ms  157 ms  161 ms  158 ms  158 ms  152 ms  151 ms  158.10 ms
Google                8.8.8.8              75 ms   1000 ms 81 ms   72 ms   75 ms   53 ms   56 ms   74 ms   52 ms   71 ms   160.90 ms
AhaDNS                45.67.219.208        190 ms  190 ms  188 ms  185 ms  187 ms  185 ms  190 ms  189 ms  191 ms  188 ms  188.30 ms
Freenom               80.80.81.81          179 ms  178 ms  202 ms  177 ms  212 ms  180 ms  239 ms  191 ms  181 ms  221 ms  196.00 ms
Freenom               80.80.80.80          181 ms  181 ms  212 ms  181 ms  221 ms  178 ms  266 ms  177 ms  177 ms  226 ms  200.00 ms
DNS.SB                185.222.222.222      230 ms  224 ms  223 ms  222 ms  232 ms  227 ms  230 ms  242 ms  224 ms  229 ms  228.30 ms
DNSPod                119.28.28.28         230 ms  231 ms  223 ms  231 ms  229 ms  225 ms  229 ms  231 ms  231 ms  231 ms  229.10 ms
DNS.SB                45.11.45.11          231 ms  233 ms  225 ms  233 ms  228 ms  238 ms  232 ms  245 ms  232 ms  227 ms  232.40 ms
dns0.eu               185.253.5.0          232 ms  218 ms  238 ms  234 ms  223 ms  303 ms  217 ms  227 ms  220 ms  230 ms  234.20 ms
Comss.one             193.17.47.1          238 ms  226 ms  241 ms  229 ms  233 ms  235 ms  233 ms  236 ms  235 ms  241 ms  234.70 ms
CZ.NICODVR            185.43.135.1         227 ms  241 ms  230 ms  236 ms  239 ms  236 ms  240 ms  228 ms  235 ms  237 ms  234.90 ms
LibreDNS              88.198.92.222        241 ms  228 ms  242 ms  242 ms  247 ms  238 ms  243 ms  231 ms  236 ms  236 ms  238.40 ms
DNSForge              176.9.1.117          237 ms  237 ms  251 ms  231 ms  233 ms  239 ms  236 ms  253 ms  242 ms  243 ms  240.20 ms
DNSForge              176.9.93.198         234 ms  237 ms  229 ms  236 ms  243 ms  241 ms  245 ms  255 ms  238 ms  245 ms  240.30 ms
DNSforFamily          94.130.180.225       229 ms  244 ms  238 ms  228 ms  245 ms  240 ms  242 ms  261 ms  237 ms  248 ms  241.20 ms
AhaDNS                5.2.75.75            244 ms  238 ms  239 ms  245 ms  248 ms  240 ms  244 ms  237 ms  239 ms  243 ms  241.70 ms
OpenNIC               217.160.70.42        233 ms  231 ms  232 ms  235 ms  259 ms  228 ms  228 ms  292 ms  233 ms  285 ms  245.60 ms
DNSforFamily          78.47.64.161         237 ms  247 ms  242 ms  237 ms  245 ms  240 ms  241 ms  389 ms  242 ms  241 ms  256.10 ms
Yandex                77.88.8.1            266 ms  278 ms  266 ms  276 ms  277 ms  278 ms  271 ms  287 ms  269 ms  275 ms  274.30 ms
Yandex                77.88.8.8            273 ms  276 ms  272 ms  277 ms  278 ms  275 ms  273 ms  273 ms  280 ms  281 ms  275.80 ms
Yandex                77.88.8.8            273 ms  276 ms  272 ms  277 ms  278 ms  275 ms  273 ms  273 ms  280 ms  281 ms  275.80 ms
Quad101               101.102.103.104      306 ms  309 ms  308 ms  306 ms  312 ms  299 ms  302 ms  299 ms  306 ms  364 ms  311.10 ms
SafeSurfer            104.155.237.225      304 ms  304 ms  304 ms  308 ms  355 ms  307 ms  346 ms  309 ms  305 ms  308 ms  315.00 ms
Mullvad               194.242.2.2          155 ms  159 ms  156 ms  1000 ms 155 ms  157 ms  156 ms  158 ms  157 ms  1000 ms 325.30 ms
DNSPod                119.29.29.29         224 ms  231 ms  450 ms  232 ms  448 ms  561 ms  230 ms  486 ms  230 ms  435 ms  352.70 ms
dns0.eu               193.110.81.0         218 ms  494 ms  467 ms  220 ms  259 ms  298 ms  477 ms  234 ms  351 ms  514 ms  353.20 ms
360SecureDNS          101.226.4.6          347 ms  382 ms  342 ms  350 ms  348 ms  345 ms  357 ms  372 ms  349 ms  345 ms  353.70 ms
Quad101               101.101.101.101      318 ms  316 ms  345 ms  316 ms  508 ms  314 ms  338 ms  339 ms  314 ms  500 ms  360.80 ms
360SecureDNS          218.30.118.6         371 ms  370 ms  368 ms  366 ms  366 ms  367 ms  370 ms  370 ms  369 ms  369 ms  368.60 ms
114DNS                114.114.115.115      358 ms  375 ms  385 ms  360 ms  374 ms  365 ms  375 ms  383 ms  373 ms  363 ms  371.10 ms
114DNS                114.114.114.114      358 ms  382 ms  364 ms  366 ms  389 ms  372 ms  375 ms  372 ms  375 ms  375 ms  372.80 ms
```

<BR>

> ### _For Windows users using the Linux subsystem (WSL)_
>
> If you get a `$'\r': command not found` error, convert the file to a Linux-compatible line-end. Example:
>
> `tr -d '\15\32' < dnsperftest.sh > dnsperftest_win.sh`
>
> Then run `bash ./dnsperftest_win.sh`

<BR>

### REMARKS
> _This script is forked from [CleanBrowsing DNS Performance Test](https://github.com/cleanbrowsing/dnsperftest)._