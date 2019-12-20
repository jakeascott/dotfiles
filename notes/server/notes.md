# Notes on my piserver

* Running ubunut arm 19.10
* Flash image to SD card
* SSH in and update

## Packages to Install
| Package  | Description                           |
|----------|---------------------------------------|
|glances   | Nice system monitoring tool           |
|ddclient  | Dynamic DNS update service            |
|fail2ban  | Bans host with multiple failed logins |
|net-tools | Nice tools including netstat          |

## Set up login with ssh keys
* Generate a new key
`ssh-keygen -t rsa -b 4096 -C <comment>`
* copy public key to server `ssh-copy-id -i /path/to/key.pub user@server.com`

## Set up firewall

Set ufw (uncomplicated firewall) to deny everything,
but allow limited access to ssh (port 22)

sudo su
ufw default deny incoming
ufw default allow outgoing
ufw limit 22/tcp
ufw enable
ufw status
exit

## Disable password auth for SSH
In `/etc/ssh/sshd_config`

* ChallengeResponseAuthentication no
* PasswordAuthentication no
* UsePAM no
* PermitRootLogin no


## Enable additional security features
In `/etc/sysctl.conf` uncomment the following lines

* net.ipv4.conf.default.rp\_filter=1
* net.ipv4.conf.all.rp\_filter=1
* net.ipv4.conf.all.accept\_redirects = 0
* net.ipv6.conf.all.accept\_redirects = 0
* net.ipv4.conf.all.send\_redirects = 0
* net.ipv4.conf.all.accept\_source\_route = 0
* net.ipv6.conf.all.accept\_source\_route = 0
* net.ipv4.conf.all.log\_martians = 1

## Tweak host config
In `/etc/host.conf` add
```
order bind,hosts
nospoof on
```
>nospoof on causes and error, not sure why
just leave it off for now.

## Enable Fail2ban
Enable Fail2ban with
```
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

## Set up DDNS
For namecheap ddns edit `/etc/ddclient.conf`

```
daemon=3600
pid=/var/run/ddclient.pid
ssl=yes
use=web, web=dynamicdns.park-your-domain.com/getip
protocol=namecheap
server=dynamicdns.park-your-domain.com
login=<domainname.com>
password=<ddns password>
<subdomain>
```

Test with
`sudo ddclient -daemon=0 -debug -verbose -noquiet`

Start and enable ddclient.service

```
sudo systemctl enable ddclient.service
sudo systemctl start ddclient.service
```

## Finishing up
* `netstat -tunlp` to check listening ports
* `ufw status` for checking firewall
* `glances` to check running status
* Check `/var/log/auth.log` for system logs
