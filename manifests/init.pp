# == Class: thunderbird
#
# Setup Thunderbird
#
# == Parameters
#
# [*manage*]
#   Manage Mozilla Thunderbird using this module. Valid values are true 
#   (default) and false. This is primarily needed with Hiera where excluding 
#   classes inherited from the lower levels in the hierarchy is not possible.
# [*manage_config*]
#   Manage Mozilla Thunderbird configuration. Valid values true (default) and 
#   false.
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
    Boolean $manage = true,
    Boolean $manage_config = true,
    Hash    $locales = {},
            $smtpservernames = undef,
            $servers = {},
            $smtpservers = {},
            $profiles = {},
            $userconfigs = {}

) inherits thunderbird::params
{

if $manage {

    include ::thunderbird::prequisites
    include ::thunderbird::install
    create_resources('thunderbird::locale', $locales)

    if $manage_config {
        class { '::thunderbird::config':
            smtpservernames => $smtpservernames,
            servers         => $servers,
            smtpservers     => $smtpservers,
            profiles        => $profiles,
            userconfigs     => $userconfigs,
        }
    }
}
}
