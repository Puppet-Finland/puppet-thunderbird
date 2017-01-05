#
# = Class: thunderbird::config
#
# Configure Mozilla Thunderbird on both system-wide and per-user basis.
#
class thunderbird::config
(
    String $smtpservernames,
    Hash   $servers,
    Hash   $smtpservers,
    Hash   $profiles,
    Hash   $userconfigs

) inherits thunderbird::params
{

    if $::kernel == 'windows' {
        $owner = undef
        $group = undef
    } else {
        $owner = $::os::params::adminuser
        $group = $::os::params::admingroup
    }

    # System-wide configuration file. Fragments are added to this file as 
    # necessary.
    concat { 'thunderbird-syspref.js':
        ensure  => present,
        path    => $::thunderbird::params::global_config,
        owner   => $owner,
        group   => $group,
        warn    => true,
        mode    => $::thunderbird::params::file_perms,
        require => Class['thunderbird::install'],
    }

    concat::fragment { "thunderbird-smtpservernames.js-${smtpservernames}":
        target  => 'thunderbird-syspref.js',
        content => template('thunderbird/smtpservernames.js.erb'),
    }

    # Generate system-wide settings
    create_resources('thunderbird::server', $servers)
    create_resources('thunderbird::smtpserver', $smtpservers)

    # Configure user's profile
    create_resources('thunderbird::profile', $profiles)

    # Configure users' email accounts
    create_resources('thunderbird::userconfig', $userconfigs)
}
