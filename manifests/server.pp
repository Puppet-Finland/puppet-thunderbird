#
# == Define: thunderbird::server
#
# Configure an IMAP/POP server for all Thunderbird users on a system.
#
define thunderbird::server
(
    $host,
    $port = 993,
    $type = 'imap',
    $sockettype = 3,
    $is_gmail = 'false'
)
{

    include os::params
    include thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-server.js-${id}":
        target => 'thunderbird-syspref.js',
        content => template('thunderbird/server.js.erb'),
        owner => $::os::params::adminuser,
        group => $::os::params::admigroup,
        mode => $::thunderbird::params::file_perms,
    }
}
