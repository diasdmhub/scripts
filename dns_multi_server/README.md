<h1 align="center">DNS Multi Server script</h1>
<p align="center">
<b>TEST A DNS SERVER LIST AGAINST A DOMAIN NAME</b>
</p>
<BR>


## USAGE
- Set up a list of DNS servers to be tested against a domain name
  - There is an example list in this repository named _`./dnslist`_. It is recommended to set up your own list based on your location and your ISP.

- The script uses the _`./dnslist`_ file name by default.
  - To change the DNS list, pass the file path as an argument or after starting the script.
<BR>

## REQUIREMENTS
- :pick: _**`Dig`**_ tool
  - If using **APT**: `apt install dnsutils`
  - If using **YUM / DNF**: `dnf install bind-utils`
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
DNS LIST PATH (default = './dnslist'): dnslist

OK   > Nameserver: 1.0.0.1 - Domain: github.com - IP answer: 20.201.28.151
OK   > Nameserver: 1.1.1.1 - Domain: github.com - IP answer: 20.201.28.151
OK   > Nameserver: 8.8.4.4 - Domain: github.com - IP answer: 20.201.28.151
OK   > Nameserver: 8.8.8.8 - Domain: github.com - IP answer: 20.201.28.151
OK   > Nameserver: 64.6.64.6 - Domain: github.com - IP answer: 20.201.28.151
OK   > Nameserver: 64.6.65.6 - Domain: github.com - IP answer: 20.201.28.151
```
