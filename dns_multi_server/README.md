<h1 align="center">DNS Multi Server script</h1>
<p align="center">
<b>QUERY A DOMAIN NAME IPv4 FROM A DNS SERVER LIST</b>
</p>

<BR>

## DOWNLOAD

[▶️ dns_multi_server.sh](https://raw.githubusercontent.com/diasdmhub/scripts/master/dns_multi_server/dns_multi_server.sh)

<BR>

## REQUIREMENTS

- ⛏️ **`Dig`** tool
    - If using **APT**: `apt install dnsutils`
    - If using **YUM / DNF**: `dnf install bind-utils`
    - If using **APK**: `apk add bind-tools`
    - If using **PACMAN**: `pacman -S bind-tools`

<BR>

## DNS PROVIDER LIST

✔️ DNS servers separated by lines.

✔️ The `#` character is the delimiter between the DNS provider IP and its name, `[IPaddress]#[ProviderName]`.
    - Do not include spaces in the provider name.
    - There is a sample list named _`dnslist`_ in this repository.

✔️ The script uses the _`./dnslist`_ filename by default.
    - To change the DNS list, pass the absolute or relative file path as the second argument.

> ℹ️ **It is recommended to set up your own list based on your location and your ISP.**

<BR>

## SYNTAX

💠 Domain and list as arguments

```bash
$ ./dns_multi_server.sh [domain] [dnslist path]
```

**OR**

💠 Domain and list asked if no arguments are passed

```bash
$ ./dns_multi_server.sh
DOMAIN NAME: github.com
DNS LIST PATH (default = './dnslist'): ./your_list.txt
```

<BR>

## EXAMPLE

```bash
$ ./dns_multi_server.sh

DOMAIN NAME: github.com
DNS LIST PATH (default = './dnslist'):

|-----------------------------------------------------------------|
| Domain: github.com                                              |
|--------|-----------------|--------------------------------------|
| RESULT |   AWNSWER       |              NAMESERVER              |
|--------|-----------------|--------------------------------------|
| OK     | 20.201.28.151   | 94.140.14.140   - AdGuard            |
| OK     | 20.201.28.151   | 94.140.14.141   - AdGuard            |
| OK     | 20.200.245.247  | 223.5.5.5       - Ali                |
| OK     | 20.200.245.247  | 223.6.6.6       - Ali                |
| OK     | 20.201.28.151   | 208.67.222.2    - CiscoOpenDNS       |
| OK     | 20.201.28.151   | 208.67.220.2    - CiscoOpenDNS       |
| OK     | 20.201.28.151   | 185.228.168.168 - CleanBrowsing      |
| OK     | 140.82.114.3    | 185.228.169.168 - CleanBrowsing      |
| OK     | 20.201.28.151   | 1.1.1.1         - CloudFlare         |
| OK     | 20.201.28.151   | 1.0.0.1         - CloudFlare         |
| OK     | 140.82.112.3    | 8.26.56.26      - Comodo             |
| OK     | 140.82.112.3    | 8.20.247.20     - Comodo             |
| OK     | 20.201.28.151   | 76.76.2.0       - ControlD           |
| OK     | 20.201.28.151   | 76.76.10.0      - ControlD           |
| OK     | 140.82.121.4    | 185.222.222.222 - DNS.SB             |
| OK     | 140.82.121.4    | 45.11.45.11     - DNS.SB             |
| OK     | 20.201.28.151   | 119.29.29.29    - DNSPod             |
| OK     | 20.201.28.151   | 119.28.28.28    - DNSPod             |
| OK     | 140.82.113.3    | 54.174.40.213   - DNSWatchGO         |
| OK     | 140.82.113.4    | 52.3.100.184    - DNSWatchGO         |
| OK     | 20.201.28.151   | 216.146.35.35   - OracleDyn          |
| OK     | 20.201.28.151   | 216.146.36.36   - OracleDyn          |
| OK     | 20.205.243.166  | 80.80.80.80     - Freenom            |
| OK     | 20.205.243.166  | 80.80.81.81     - Freenom            |
| OK     | 20.201.28.151   | 8.8.8.8         - Google             |
| OK     | 20.201.28.151   | 8.8.4.4         - Google             |
| OK     | 140.82.114.4    | 74.82.42.42     - HurricaneElectric  |
| OK     |                 | 194.242.2.2     - Mullvad            |
| OK     | 20.201.28.151   | 156.154.70.1    - Neustar            |
| OK     | 20.201.28.151   | 156.154.71.1    - Neustar            |
| OK     | 20.201.28.151   | 45.90.28.0      - NextDNS            |
| OK     | 20.201.28.151   | 45.90.30.0      - NextDNS            |
| OK     | 20.201.28.151   | 193.110.81.0    - dns0.eu            |
| OK     | 20.201.28.151   | 185.253.5.0     - dns0.eu            |
| OK     | 20.201.28.151   | 9.9.9.10        - Quad9              |
| OK     | 20.201.28.151   | 149.112.112.10  - Quad9              |
| OK     | 20.201.28.151   | 195.46.39.39    - SafeDNS            |
| OK     | 20.201.28.151   | 195.46.39.40    - SafeDNS            |
| OK     | 20.205.243.166  | 101.226.4.6     - 360SecureDNS       |
| OK     | 20.205.243.166  | 218.30.118.6    - 360SecureDNS       |
| OK     | 20.201.28.151   | 64.6.64.6       - Verisign           |
| OK     | 20.201.28.151   | 64.6.65.6       - Verisign           |
| OK     | 20.27.177.113   | 104.155.237.225 - SafeSurfer         |
| OK     | 140.82.114.4    | 104.197.28.121  - SafeSurfer         |
| OK     | 140.82.114.4    | 149.112.121.10  - CIRACanadianShield |
| OK     | 140.82.112.3    | 149.112.122.10  - CIRACanadianShield |
| OK     | 140.82.121.4    | 193.17.47.1     - Comss.one          |
| OK     | 20.201.28.151   | 76.76.2.22      - CZ.NICODVR         |
| OK     | 140.82.121.4    | 185.43.135.1    - CZ.NICODVR         |
| OK     | 140.82.121.3    | 94.130.180.225  - DNSforFamily       |
| OK     | 140.82.121.4    | 78.47.64.161    - DNSforFamily       |
| OK     | 20.201.28.151   | 76.76.2.22      - FondationRestena   |
| OK     | 20.205.243.166  | 114.114.114.114 - 114DNS             |
| OK     | 20.205.243.166  | 114.114.115.115 - 114DNS             |
| OK     | 140.82.121.4    | 88.198.92.222   - LibreDNS           |
| OK     | 140.82.121.3    | 217.160.70.42   - OpenNIC            |
| OK     | 20.27.177.113   | 101.101.101.101 - Quad101            |
| OK     | 20.27.177.113   | 101.102.103.104 - Quad101            |
| OK     | 140.82.121.4    | 77.88.8.8       - Yandex             |
| OK     | 140.82.121.3    | 77.88.8.1       - Yandex             |
| OK     | 140.82.121.4    | 5.2.75.75       - AhaDNS             |
| OK     | 140.82.116.4    | 45.67.219.208   - AhaDNS             |
| OK     | 140.82.121.3    | 176.9.93.198    - DNSForge           |
| OK     | 140.82.121.4    | 176.9.1.117     - DNSForge           |
| OK     |                 | 45.54.76.1      - deSEC.io           |
| OK     |                 | 157.53.224.1    - deSEC.org          |
|--------|-----------------|--------------------------------------|
```