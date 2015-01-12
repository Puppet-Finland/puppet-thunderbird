#
# == Define: thunderbird::locale
#
# Ensure a Thunderbird locale is present on the system. Only needed on 
# Debian/Ubuntu at the moment.
#
# == Parameters
#
# [*id*]
#   Define the country code for the locale to instal. For example use 'fi' for 
#   Finnish or 'it' for Italian.
#
define thunderbird::locale
(
    $id
)
{
    include thunderbird::params

    if $::osfamily == 'Debian' {
        package { "thunderbird-locale-${id}":
            name => "${::thunderbird::params::package_name_locale}-${id}",
            ensure => installed,
            require => Class['thunderbird::install'],
        }
    }
}
