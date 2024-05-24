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
| NextDNS             | 45.90.28.0       | 45.90.30.0       | Yes     | No   |
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
./dnsperftest.sh | sort -k 24 -n
```

```
DNS PROVIDER PERFORMANCE TEST
--------------------------------------------------------------------------------------------------------------------------
| Provider           | IP / Test >     | 1    | 2    | 3    | 4    | 5    | 6    | 7    | 8    | 9    | 10   | Average   |
--------------------------------------------------------------------------------------------------------------------------
| [local_nameserver] | 127.0.0.1       |    1 |    1 |    1 |    1 |    1 |    1 |    1 |    1 |    1 |    1 |   1.0  ms |
| CloudFlare         | 1.0.0.1         |   16 |   24 |   18 |   18 |   19 |   18 |   29 |   20 |   19 |   17 |  19.80 ms |
| AdGuard            | 94.140.14.140   |   18 |   24 |   20 |   18 |   18 |   68 |   17 |   18 |   20 |   18 |  23.90 ms |
| AdGuard            | 94.140.14.141   |   18 |   24 |   18 |   17 |   25 |   16 |   19 |   22 |   16 |   18 |  19.30 ms |
| CiscoOpenDNS       | 208.67.222.2    |   75 |   29 |   19 |   23 |   30 |   77 |   31 |   17 |   23 |   18 |  34.20 ms |
| CloudFlare         | 1.1.1.1         |   18 |   35 |   18 |   17 |   16 |   24 |   21 |   20 |   17 |   19 |  20.50 ms |
| Verisign           | 64.6.65.6       |   20 |   20 |   21 |   23 |   21 |   26 |   21 |   26 |   21 |   19 |  21.80 ms |
| Quad9              | 9.9.9.10        |   24 |   17 |   23 |   25 |   25 |   24 |   17 |   18 |   19 |   20 |  21.20 ms |
| CZ.NICODVR         | 76.76.2.22      |  146 |   22 |   23 |   20 |   20 |   76 |   23 |   24 |   22 |   21 |  39.70 ms |
| ControlD           | 76.76.10.0      |   22 |   20 |   21 |   22 |   22 |   28 |   20 |   19 |   21 |   21 |  21.60 ms |
| FondationRestena   | 76.76.2.22      |  152 |   24 |   22 |   22 |   22 |   23 |   23 |   21 |   25 |   21 |  35.50 ms |
| Neustar            | 156.154.70.1    |   21 |   26 |   18 |   20 |   21 |   18 |   20 |   20 |   23 |   21 |  20.80 ms |
| Neustar            | 156.154.71.1    |   19 |   19 |   18 |   27 |   19 |   26 |   19 |   33 |   22 |   21 |  22.30 ms |
| SafeDNS            | 195.46.39.40    |   20 |   20 |   21 |   19 |   22 |   23 |   21 |   21 |   24 |   22 |  21.30 ms |
| CiscoOpenDNS       | 208.67.220.2    |   75 |   22 |   19 |   18 |   16 |   76 |   25 |   20 |   16 |   23 |  31.0  ms |
| Google             | 8.8.4.4         |   19 |   19 |   23 |   21 |   20 |   76 |   22 |   27 |   18 |   23 |  26.80 ms |
| CleanBrowsing      | 185.228.168.168 |   33 |   20 |   20 |   20 |   19 |   21 |   20 |   20 |   22 |   24 |  21.90 ms |
| Quad9              | 149.112.112.10  |   32 |   24 |   26 |   24 |   27 |   32 |   28 |   27 |   24 |   24 |  26.80 ms |
| SafeDNS            | 195.46.39.39    |   20 |  160 |   22 |   21 |   22 |   22 |   22 |   19 |   20 |   25 |  35.30 ms |
| Verisign           | 64.6.64.6       |   32 |   26 |   31 |   25 |   26 |   23 |   20 |   17 |   25 |   25 |  25.0  ms |
| NextDNS            | 45.90.28.0      |   26 |   26 |   25 |   27 |   18 |   35 |   19 |   34 |   32 |   28 |  27.0  ms |
| Google             | 8.8.8.8         |   21 |   32 |   30 |   21 |   17 |   88 |   76 |   48 |   24 |   32 |  38.90 ms |
| OracleDyn          | 216.146.35.35   |   50 |   20 |   25 |   20 |   40 |   22 |   36 |   24 |   20 |   36 |  29.30 ms |
| OracleDyn          | 216.146.36.36   |   36 |   62 |   23 |   41 |   21 |   26 | 1000 |   20 |   20 |   61 | 131.0  ms |
| ControlD           | 76.76.2.0       |   27 |   21 |   23 |   22 |   22 |   79 |   22 |   25 |   27 |   64 |  33.20 ms |
| NextDNS            | 45.90.30.0      |   42 |   64 |   69 |   64 |   70 |  115 |   52 |   43 |   56 |   69 |  64.40 ms |
| deSEC.org          | 157.53.224.1    |   71 |   76 |   71 |   77 |   72 |   70 |   71 |   69 |   71 |   71 |  71.90 ms |
| CleanBrowsing      | 185.228.169.168 |  131 |  127 |  134 |  128 |  130 |  129 |  137 |  132 |  130 |  129 | 130.70 ms |
| HurricaneElectric  | 74.82.42.42     |  132 |  151 |  131 |  134 |  130 |  129 |  160 |  147 |  134 |  134 | 138.20 ms |
| Comodo             | 8.26.56.26      |  132 |  164 |  140 |  135 |  136 |  160 |  133 |  138 |  129 |  138 | 140.50 ms |
| SafeSurfer         | 104.197.28.121  |  156 |  162 |  155 |  152 |  156 |  157 |  181 |  157 |  155 |  153 | 158.40 ms |
| DNSWatchGO         | 54.174.40.213   |  161 |  158 |  166 |  157 |  154 |  162 |  161 |  156 |  159 |  155 | 158.90 ms |
| CIRACanadianShield | 149.112.122.10  |  153 |  158 |  154 |  163 |  151 |  158 |  152 |  153 |  150 |  156 | 154.80 ms |
| Comodo             | 8.20.247.20     |  131 |  131 |  136 |  157 |  130 |  158 |  157 |  166 |  164 |  158 | 148.80 ms |
| CIRACanadianShield | 149.112.121.10  |  165 |  162 |  157 |  163 |  159 |  157 |  157 |  157 |  159 |  159 | 159.50 ms |
| deSEC.io           | 45.54.76.1      |  157 |  163 |  156 |  157 |  157 |  162 |  158 |  158 |  157 |  160 | 158.50 ms |
| DNSWatchGO         | 52.3.100.184    |  159 |  157 |  159 |  164 |  153 |  165 |  166 |  167 |  159 |  161 | 161.0  ms |
| AhaDNS             | 5.2.75.75       |  222 |  222 |  221 |  221 |  222 |  221 |  222 |  227 |  227 |  222 | 222.70 ms |
| AhaDNS             | 45.67.219.208   |  195 |  191 |  192 |  191 |  198 |  188 |  185 |  195 |  193 |  226 | 195.40 ms |
| DNS.SB             | 45.11.45.11     |  229 |  232 |  229 |  237 |  229 |  234 |  239 |  240 |  234 |  230 | 233.30 ms |
| DNS.SB             | 185.222.222.222 |  233 |  225 |  229 |  223 |  226 |  248 |  234 |  223 |  225 |  233 | 229.90 ms |
| DNSPod             | 119.28.28.28    |  233 |  229 |  236 |  227 |  232 |  232 |  228 |  235 |  232 |  233 | 231.70 ms |
| CZ.NICODVR         | 185.43.135.1    |  237 |  231 |  239 |  233 |  233 |  234 |  242 |  231 |  233 |  234 | 234.70 ms |
| DNSForge           | 176.9.1.117     |  244 |  242 |  236 |  244 |  237 |  236 |  235 |  235 |  237 |  235 | 238.10 ms |
| dns0.eu            | 193.110.81.0    |  234 |  237 |  225 |  219 |  229 |  231 |  234 |  223 |  225 |  235 | 229.20 ms |
| Comss.one          | 193.17.47.1     |  241 |  238 |  240 |  241 |  244 |  232 |  232 |  241 |  231 |  239 | 237.90 ms |
| LibreDNS           | 88.198.92.222   |  239 |  246 |  235 |  244 |  242 |  247 |  239 |  238 |  242 |  240 | 241.20 ms |
| dns0.eu            | 185.253.5.0     | 1000 | 1000 |  220 | 1000 |  222 |  225 |  244 |  234 | 1000 |  241 | 538.60 ms |
| DNSForge           | 176.9.93.198    |  235 |  235 |  236 |  233 |  238 |  237 |  245 |  238 |  235 |  242 | 237.40 ms |
| DNSforFamily       | 78.47.64.161    |  260 |  245 |  244 |  244 |  242 |  257 |  249 |  250 |  243 |  242 | 247.60 ms |
| DNSforFamily       | 94.130.180.225  |  239 |  239 |  238 |  237 |  249 |  254 |  261 |  240 |  240 |  249 | 244.60 ms |
| Yandex             | 77.88.8.1       |  275 |  280 |  278 |  275 |  272 |  268 |  279 |  270 |  271 |  273 | 274.10 ms |
| Yandex             | 77.88.8.8       |  276 |  268 |  276 |  268 |  278 |  278 |  277 |  275 |  266 |  277 | 273.90 ms |
| OpenNIC            | 217.160.70.42   |  232 |  259 |  230 |  246 |  233 |  276 |  249 |  291 |  269 |  299 | 258.40 ms |
| Quad101            | 101.102.103.104 |  307 |  319 |  306 |  316 |  309 |  310 |  301 |  306 |  307 |  301 | 308.20 ms |
| SafeSurfer         | 104.155.237.225 |  309 |  309 |  306 |  306 |  305 |  350 |  309 |  438 |  305 |  315 | 325.20 ms |
| 360SecureDNS       | 218.30.118.6    |  343 |  346 |  350 |  431 |  516 |  353 |  344 |  347 |  350 |  354 | 373.40 ms |
| 114DNS             | 114.114.115.115 |  380 |  403 |  384 |  374 |  369 |  372 |  403 |  376 |  364 |  367 | 379.20 ms |
| Ali                | 223.6.6.6       |  394 |  397 |  408 |  402 |  403 |  398 |  400 |  405 |  399 |  395 | 400.10 ms |
| Ali                | 223.5.5.5       |  395 |  401 |  393 |  392 |  409 |  401 |  402 |  400 |  405 |  400 | 399.80 ms |
| 114DNS             | 114.114.114.114 |  406 |  375 |  372 |  369 |  365 |  367 |  368 |  372 |  376 |  409 | 377.90 ms |
| Quad101            | 101.101.101.101 |  324 |  360 |  324 |  330 |  331 |  318 |  326 |  317 |  325 |  425 | 338.0  ms |
| DNSPod             | 119.29.29.29    |  231 |  463 |  436 |  234 |  230 |  490 |  635 |  455 |  443 |  448 | 406.50 ms |
| Freenom            | 80.80.80.80     |  627 |  967 |  705 |  645 |  367 |  673 |  752 |  705 |  654 |  599 | 669.40 ms |
| Freenom            | 80.80.81.81     |  680 |  371 |  659 |  681 |  626 |  392 |  645 |  653 | 1257 |  673 | 663.70 ms |
| 360SecureDNS       | 101.226.4.6     |  365 |  364 |  371 |  393 |  525 |  367 |  348 |  356 |  350 | 1000 | 443.90 ms |
| Mullvad            | 194.242.2.2     |  156 |  162 |  161 | 1000 |  153 |  154 |  161 |  161 |  163 | 1000 | 327.10 ms |
--------------------------------------------------------------------------------------------------------------------------
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