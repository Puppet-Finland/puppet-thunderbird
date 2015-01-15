#
# = Class: thunderbird::config
#
# Configure Mozilla Thunderbird on both system-wide and per-user basis.
#
class thunderbird::config
(
    $servers,
    $smtpservers,
    $profiles,
    $identities
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

    # Generate system-wide settings
    create_resources('thunderbird::server', $servers)
    create_resources('thunderbird::smtpserver', $smtpservers)

    # Per-user settings
    create_resources('thunderbird::profile', $profiles)
    create_resources('thunderbird::identity', $identities)
}
