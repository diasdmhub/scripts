<h1 align="center">DNS Multi Server script</h1>
<p align="center">
<b>TEST A DNS SERVER LIST AGAINST A DOMAIN NAME</b>
</p>

<BR>

## DOWNLOAD

[▶️ dns_multi_server.sh](https://raw.githubusercontent.com/diasdmhub/scripts/master/dns_multi_server/dns_multi_server.sh)

<BR>

## USAGE

- [X] Set up a list of DNS servers to be tested against a domain name
  - There is an example list in this repository named _`./dnslist`_. It is recommended to set up your own list based on your location and your ISP.

- [X] The script uses the _`./dnslist`_ file name by default.
  - To change the DNS list, pass the file path as an argument or after starting the script.

<BR>

## REQUIREMENTS

- ⛏️ **`Dig`** tool
  - If using **APT**: `apt install dnsutils`
  - If using **YUM / DNF**: `dnf install bind-utils`
  - If using **APK**: `apk add bind-tools`
  - If using **PACMAN**: `pacman -S bind-tools`

<BR>

## SYNTAX

> Domain and list as arguments
```bash
$ ./dns_multi_server.sh [domain] [dnslist path]
```

**OR**

> Domain and list asked if no arguments are passed
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

--------------------------------------------
Domain: github.com                         |
--------------------------------------------
RESULT |   NAMESERVER    |     AWNSWER     |
--------------------------------------------
OK     | 1.1.1.1         | 20.201.28.151   |
OK     | 1.0.0.1         | 20.201.28.151   |
OK     | 5.2.75.75       | 140.82.121.3    |
OK     | 8.26.56.26      | 140.82.113.3    |
OK     | 8.20.247.20     | 140.82.113.3    |
OK     | 8.8.8.8         | 20.201.28.151   |
OK     | 8.8.4.4         | 20.201.28.151   |
OK     | 9.9.9.10        | 20.201.28.151   |
OK     | 45.11.45.11     | 140.82.121.4    |
OK     | 45.67.219.208   | 140.82.116.3    |
OK     | 45.54.76.1      |                 |
OK     | 52.3.100.184    | 140.82.112.3    |
OK     | 54.174.40.213   | 140.82.113.3    |
OK     | 64.6.64.6       | 140.82.113.3    |
OK     | 64.6.65.6       | 140.82.114.4    |
OK     | 74.82.42.42     | 140.82.114.3    |
OK     | 76.76.2.0       | 20.201.28.151   |
OK     | 76.76.10.0      | 20.201.28.151   |
OK     | 76.76.2.22      | 20.201.28.151   |
OK     | 76.76.2.22      | 20.201.28.151   |
OK     | 77.88.8.8       | 140.82.121.3    |
OK     | 77.88.8.1       | 140.82.121.4    |
OK     | 78.47.64.161    | 140.82.121.3    |
OK     | 80.80.80.80     | 140.82.121.3    |
OK     | 80.80.81.81     | 140.82.121.3    |
OK     | 88.198.92.222   | 140.82.121.4    |
OK     | 94.140.14.140   | 20.201.28.151   |
OK     | 94.140.14.141   | 20.201.28.151   |
OK     | 94.130.180.225  | 140.82.121.4    |
OK     | 101.226.4.6     | 20.205.243.166  |
OK     | 101.101.101.101 | 20.27.177.113   |
OK     | 101.102.103.104 | 20.27.177.113   |
OK     | 104.155.237.225 | 20.27.177.113   |
OK     | 104.197.28.121  | 140.82.112.3    |
OK     | 114.114.114.114 | 20.205.243.166  |
OK     | 114.114.115.115 | 20.205.243.166  |
OK     | 119.29.29.29    | 20.201.28.151   |
OK     | 119.28.28.28    | 20.201.28.151   |
OK     | 149.112.112.10  | 20.201.28.151   |
OK     | 149.112.121.10  | 140.82.112.3    |
OK     | 149.112.122.10  | 140.82.113.3    |
OK     | 156.154.70.1    | 140.82.113.3    |
OK     | 156.154.71.1    | 140.82.114.4    |
OK     | 157.53.224.1    |                 |
OK     | 176.9.93.198    | 140.82.121.4    |
OK     | 176.9.1.117     | 140.82.121.3    |
OK     | 185.228.168.168 | 20.201.28.151   |
OK     | 185.228.169.168 | 140.82.114.4    |
OK     | 185.222.222.222 | 140.82.121.4    |
OK     | 185.253.5.0     | 20.201.28.151   |
OK     | 185.43.135.1    | 140.82.121.3    |
OK     | 193.110.81.0    | 20.201.28.151   |
OK     | 193.17.47.1     | 140.82.121.4    |
OK     | 194.242.2.2     |                 |
OK     | 195.46.39.39    | 20.201.28.151   |
OK     | 195.46.39.40    | 20.201.28.151   |
OK     | 208.67.222.2    | 20.201.28.151   |
OK     | 208.67.220.2    | 20.201.28.151   |
OK     | 216.146.35.35   | 20.201.28.151   |
OK     | 216.146.36.36   | 20.201.28.151   |
OK     | 217.160.70.42   | 140.82.121.3    |
OK     | 218.30.118.6    | 20.205.243.166  |
OK     | 223.5.5.5       | 20.200.245.247  |
OK     | 223.6.6.6       | 20.200.245.247  |
--------------------------------------------
```
