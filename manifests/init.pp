# == Class: thunderbird
#
# This class install and configures Mozilla Thunderbird. It makes heavy use of 
# hash parameters to allow complex configurations on a per-user and per-email 
# account basis. Typically all of the configuration should be placed high-up in 
# the hierarchy, so that every user on every desktop/laptop gets the same 
# Mozilla Thunderbird configuration. The default configuration can then be 
# overridden on a node-by-node basis.
#
# This module has been tested on Linux (Ubuntu 14.04) and Windows 7 64-bit. 
# Other *NIX variants such as RedHat, Debian and FreeBSD as well as 32-bit 
# Windows have not been tested, but should work out of the box or with minor 
# modifications. Adding MacOS X support should be fairly straightforward.
#
# Currently there are a few limitations:
#
# - Only one identity per email account
# - Only system-wide IMAP/POP/SMTP server configuration
# - Only email account details are currently configured
# - No way to reuse global IMAP/POP server info for several accounts of a same
#   system user
# - User's profiles.ini get's overwritten, so does not co-exist nicely with
#   manually configured accounts. This might be considered a feature.
#
# == Parameters
#
# [*manage*]
#   Manage Mozilla Thunderbird using this module. Valid values 'yes' (default) 
#   and 'no'. This is primarily needed with Hiera where excluding classes 
#   inherited from the lower levels in the hierarchy is not possible.
# [*manage_config*]
#   Manage Mozilla Thunderbird configuration. Valid values 'yes' (default) and 
#   'no'.
# [*locales*]
#   A hash of thunderbird::locale resources to realize. Currently only needed on 
#   Debian and Ubuntu where the locales are packaged separately. Defining these 
#   on other operating systems is harmless.
# [*smtpservernames*]
#   A comma-separated list of SMTP servers that should be active. No spaces are 
#   allowed between the entries. This information could be gathered from the 
#   $smtpservers hash, but this manual approach was chosen for it's simplicity.
# [*servers*]
#   A hash of thunderbird::server resources to realize. These are common to all 
#   users on the system.
# [*snmpservers*]
#   A hash of thunderbird::snmpserver resources to realize. These are common to 
#   all users on the system.
# [*profiles*]
#   A hash of thunderbird::profile resources to realize. There is one of these 
#   per-user on a single system.
# [*userconfigs*]
#   A hash of thunderbird::userconfig resources to realize. There can be many of 
#   these per user. Currently thunderbird::userconfig resources only configure 
#   email accounts, but their use can be extended to other areas.
# 
# == Examples
#
# Example usage of the class in Hiera:
#
#  ---
#  classes:
#      - thunderbird
#
#  # Globally defined IMAP/POP servers  
#  thunderbird::servers:
#      gmail:
#          host: 'imap.gmail.com'
#          is_gmail: 'true'
#      rackspace:
#          host: 'secure.emailsrvr.com'
#
#  # Globally defined SMTP servers  
#  thunderbird::smtpservers:
#      gmail:
#          host: 'smtp.gmail.com'
#          port: 587
#          try_ssl: 2
#          auth_method: 3
#          description: 'Gmail SMTP server'
#      rackspace:
#          host: 'secure.emailsrvr.com'
#          port: 465
#          try_ssl: 3
#          auth_method: 1
#          description: 'Rackspace SMTP server'
#
#  # User profiles (one per system user)
#  thunderbird::profiles:
#      john:
#          accounts: 'john_gmail,john_rackspace'
#          defaultaccount: 'john_gmail'
#
#  # Email account details. One or more per user.
#  thunderbird::userconfigs:
#      john_gmail:
#          username: 'john'
#          email: 'john.doe@gmail.com'
#          fullname: 'John Doe'
#          organization: ''
#          server: 'gmail'
#          server_username: 'john.doe'
#          smtpserver: 'gmail'
#      john_rackspace:
#          username: 'john'
#          email: 'john@domain.com'
#          fullname: 'John Doe'
#          organization: 'ACME Terraforming, Inc.'
#          server: 'rackspace'
#          smtpserver: 'rackspace'
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class thunderbird
(
    $manage = 'yes',
    $manage_config = 'yes',
    $locales = {},
    $smtpservernames = '',
    $servers = {},
    $smtpservers = {},
    $profiles = {},
    $userconfigs = {}

) inherits thunderbird::params
{

if $manage == 'yes' {

    include thunderbird::install
    create_resources('thunderbird::locale', $locales)

    if $manage_config == 'yes' {
        class { 'thunderbird::config':
            smtpservernames => $smtpservernames,
            servers => $servers,
            smtpservers => $smtpservers,
            profiles => $profiles,
            userconfigs => $userconfigs,
        }
    }
}
}
