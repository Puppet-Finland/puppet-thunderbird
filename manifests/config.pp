#
# = Class: thunderbird::config
#
# Configure Mozilla Thunderbird on both system-wide and per-user basis.
#
class thunderbird::config
(
    $smtpservernames,
    $servers,
    $smtpservers,
    $profiles,
    $identities,
    $serverlogins,
    $smtpserverlogins,
    $accounts,
    $userconfigs
)
{

    include os::params
    include thunderbird::params

    # System-wide configuration file. Fragments are added to this file as 
    # necessary.
    concat { 'thunderbird-syspref.js':
        path => $::thunderbird::params::global_config,
        ensure => present,
        owner => $::os::params::adminuser,
        group => $::os::params::admingroup,
        warn => true,
        mode => $::thunderbird::params::file_perms,
        require => Class['thunderbird::install'],
    }

    concat::fragment { "thunderbird-smtpservernames.js-${smtpservernames}":
        target => 'thunderbird-syspref.js',
        content => template('thunderbird/smtpservernames.js.erb'),
        owner => $::os::params::adminuser,
        group => $::os::params::admigroup,
        mode => $::thunderbird::params::file_perms,
    }

    # Generate system-wide settings
    create_resources('thunderbird::server', $servers)
    create_resources('thunderbird::smtpserver', $smtpservers)

    # Per-user settings
    create_resources('thunderbird::profile', $profiles)
    create_resources('thunderbird::identity', $identities)
    create_resources('thunderbird::serverlogin', $serverlogins)
    create_resources('thunderbird::smtpserverlogin', $smtpserverlogins)
    create_resources('thunderbird::account', $accounts)
    create_resources('thunderbird::userconfig', $userconfigs)
}
