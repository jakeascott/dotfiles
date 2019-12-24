# Installing Nextcloud server on Ubuntu Server 18.04

I'll be using the Nextcloud snap package.
Install using `sudo snap install nextcloud`.
The snap should automatically start running.

## Point nextcloud data folder to external hard drive

Ensure the removable-media connection is enabled with `sudo snap connect nextcloud:removable-media`
The snap package will only have access to drives mounted in `/media/`.

In `/var/snap/nextcloud/current/nextcloud/config/autoconfig.php` point the `directory` variable to the desired directory.

```
// ...
'directory' => '/path/to/folder',
// ...
```

Then restart the php service `sudo snap restart nextcloud.php-fpm`

> NOTE: This should be done before configuring and admin user.

## Cofigure an admin account

This can be done through the web interface, but it's generally safer to do via command line.

* Run `sudo nextcloud.manual-install <user> <password>`

You should see the following message **Nextcloud was successfully installed**.
It may take a bit, just wait.

## Adjust trusted domains

By default nextcloud will only allow connections from *localhost*.
To see which domains are allowed use `sudo nextcloud.occ config:system:get trusted_domains`.
To add a domain or ip run `sudo nextcloud.occ config:system:set trusted_domains <n> --value=<domain-name>`.
Here **n** is the domain number (e.g. 1 for the first additional domain).

## Securing with SSL

There are two main ways to get SSL certs, self-signed and let's encrypt.
Let's encrypt requires ports 80 and 443 to be forwarded from the outside internet.

### SSL with Let's Encrypt
Here we can use *Let's Encrypt* to sign SSL certs.
This will require opening the firewall to 80,443/tcp and forwarding the ports from the router.

* Enable with `sudo nextcloud.enable-https lets-encrypt`. You will be asked to agree to the terms available [here](https://letsencrypt.org/repository/).
* Provide an email address and the domain name for this machine.
* It may take a bit.

## Log into nextcloud for the first time.

Simply point the browser to `https://<domain-name>` and everything should be working.

