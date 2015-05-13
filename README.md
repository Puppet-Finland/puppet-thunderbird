# thunderbird

A Puppet module for managing Mozilla Thunderbird

# Module usage

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
