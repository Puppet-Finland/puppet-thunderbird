# thunderbird

A Puppet module for installing and configuring Mozilla Thunderbird. It makes 
heavy use of hash parameters to allow complex configurations on a per-user and 
per-email account basis. Typically all of the configuration should be placed 
high-up in the hierarchy, so that every user on every desktop/laptop gets the 
same Mozilla Thunderbird configuration. The default configuration can then be 
overridden on a node-by-node basis.

This module has been tested on Linux (Ubuntu 14.04) and Windows 7 64-bit. Other 
*NIX variants such as RedHat, Debian and FreeBSD as well as 32-bit Windows have 
not been tested, but should work out of the box or with minor modifications. 
Adding MacOS X support should be fairly straightforward.

Currently there are a few limitations:

- Only one identity per email account
- Only system-wide IMAP/POP/SMTP server configuration
- Only email account details are currently configured
- No way to reuse global IMAP/POP server info for several accounts of a same
  system user
- User's profiles.ini get's overwritten, so does not co-exist nicely with
  manually configured accounts. This might be considered a feature.

# Module usage

Example usage of the class in Hiera:

    classes:
        - thunderbird
    
    # Globally defined IMAP/POP servers
    thunderbird::servers:
        gmail:
            host: 'imap.gmail.com'
            is_gmail: 'true'
        rackspace:
            host: 'secure.emailsrvr.com'
    
    # Globally defined SMTP servers
    thunderbird::smtpservers:
        gmail:
            host: 'smtp.gmail.com'
            port: 587
            try_ssl: 2
            auth_method: 3
            description: 'Gmail SMTP server'
        rackspace:
            host: 'secure.emailsrvr.com'
            port: 465
            try_ssl: 3
            auth_method: 1
            description: 'Rackspace SMTP server'
    
    # User profiles (one per system user)
    thunderbird::profiles:
        john:
            accounts: 'john_gmail,john_rackspace'
            defaultaccount: 'john_gmail'
    
    # Email account details. One or more per user.
    thunderbird::userconfigs:
        john_gmail:
            username: 'john'
            email: 'john.doe@gmail.com'
            fullname: 'John Doe'
            organization: ''
            server: 'gmail'
            server_realusername: 'john.doe'
            smtpserver: 'gmail'
        john_rackspace:
            username: 'john'
            email: 'john@domain.com'
            fullname: 'John Doe'
            organization: 'ACME Terraforming, Inc.'
            server: 'rackspace'
            smtpserver: 'rackspace'

For details see

* [Class: thunderbird](manifests/init.pp)
* [Define: thunderbird::locale](manifests/locale.pp)
* [Define: thunderbird::server](manifests/server.pp)
* [Define: thunderbird::smtpserver](manifests/smtpserver.pp)
* [Define: thunderbird::profile](manifests/profile.pp)
* [Define: thunderbird::userconfig](manifests/userconfig.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Ubuntu 12.04 and 14.04
* Debian 8
* Fedora 21
* Windows 7

The following operating systems should work out of the box or with small 
modifications:

* RedHat/CentOS
* FreeBSD

For details see [params.pp](manifests/params.pp).
