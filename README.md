# thunderbird

A Puppet module for managing Mozilla Thunderbird

# Module usage

* [Class: thunderbird](manifests/init.pp)
* [Define: thunderbird::locale](manifests/locale.pp)
* [Define: thunderbird::server](manifests/server.pp)
* [Define: thunderbird::smtpserver](manifests/smtpserver.pp)
* [Define: thunderbird::profile](manifests/profile.pp)
* [Define: thunderbird::userconfig](manifests/profile.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Ubuntu 12.04 32-bit
* Ubuntu 14.04 64-bit
* Windows 7 64-bit

The following operating systems should work out of the box or with small 
modifications:

* Debian
* RedHat/CentOS
* FreeBSD

For details see [params.pp](manifests/params.pp).
