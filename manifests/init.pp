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
    $servers = {},
    $smtpservers = {},
    $profiles = {},
    $identities = {},
    $serverlogins = {}

) inherits thunderbird::params
{

if $manage == 'yes' {

    include thunderbird::install
    create_resources('thunderbird::locale', $locales)

    if $manage_config == 'yes' {
        class { 'thunderbird::config':
            servers => $servers,
            smtpservers => $smtpservers,
            profiles => $profiles,
            identities => $identities,
            serverlogins => $serverlogins,
        }
    }
}
}
