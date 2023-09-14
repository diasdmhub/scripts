<h1 align="center">Auto SSH Copy Id Script</h1>
<p align="center">
<b>COPY A USER SSH PUBLIC KEY TO MULTIPLE HOSTS</b>
</p>
<BR>

## DOWNLOAD
[▶️ auto_ssh_copy_id.sh](https://raw.githubusercontent.com/diasdmhub/scripts/master/auto_ssh_copy_id/auto_ssh_copy_id.sh)

<BR>

## USAGE
- [X] All remote hosts in the list must use the same user and password :warning:
- [X] Set up a list of hosts you wish to connect via SSH.
  - By default, the host list uses the **`./hostlist.txt`** file
- [X] The list must use an IP address or domain name

#### List example:
```
  192.168.80.10
  192.168.80.11
  10.168.80.100
  10.168.80.110
  hostname.mydomain
  hostname.other.domain
```

<BR>

  
## REQUIREMENTS
- **`sshpass`** package
  - **APT** - `apt install sshpass`
  - **DNF** - `dnf install sshpass`

- **`ssh-copy-id`** script
  - Usually comes with **OpenSSH** or **Dropbear**

- Local host priviledge required
  - Use `sudo` if not using **_root_**
- Public key must be set for local user
  - Example: `ssh-keygen -b 4096 -t rsa`
<BR>


## SYNTAX
> Pass arguments at command line
```bash
  ./auto_ssh_copy_id.sh [local user] [remote user] [remote pass] [path to host list] [path to local pub key]
```
**OR**
> Pass arguments interactively
```bash
  $ /home/dan/github/scripts/auto_ssh_copy_id/auto_ssh_copy_id.sh
LOCAL USER FOR REMOTE ACCESS: [local user]
REMOTE USER: [remote user]
REMOTE USER PASSWORD: [remote user pass]
HOST LIST FILE PATH (default ./hostlist.txt): /path/to/host/list.txt
LOCAL USER PUB KEY PATH (default ~/.ssh/id_rsa.pub): /path/to/public/key.pub
```
<BR>


## EXAMPLE
```bash
$ /root/github/scripts/auto_ssh_copy_id/auto_ssh_copy_id.sh

LOCAL USER FOR REMOTE ACCESS: root
REMOTE USER: root
REMOTE USER PASSWORD: [remote user pass]
HOST LIST FILE PATH (default ./hostlist.txt):
        Default list set

LOCAL USER PUB KEY PATH (default ~/.ssh/id_rsa.pub):
        Default key set

/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh -o 'StrictHostKeyChecking=no' 'root@192.168.7.10'"
and check to make sure that only the key(s) you wanted were added.

OK - 192.168.7.10
```
