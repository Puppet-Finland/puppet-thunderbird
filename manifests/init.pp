# == Class: thunderbird
#
# This class install and configures Mozilla Thunderbird
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
#   A hash of thunderbird::profile resources to realize. These are 
#   user-specific.
# [*identities*]
#   A hash of thunderbird::identity resources to realize. These are 
#   user-specific.
# [*serverlogins*]
#   A hash of thunderbird::serverlogin resources to realize. These are 
#   user-specific.
# [*smtpserverlogins*]
#   A hash of thunderbird::smtpserverlogin resources to realize. These are 
#   user-specific.
# [*accounts*]
#   A hash of thunderbird::account resources to realize. These are 
#   user-specific.
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
    $identities = {},
    $serverlogins = {},
    $smtpserverlogins = {},
    $accounts = {}

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
            identities => $identities,
            serverlogins => $serverlogins,
            smtpserverlogins => $smtpserverlogins,
            accounts => $accounts,
        }
    }
}
}
