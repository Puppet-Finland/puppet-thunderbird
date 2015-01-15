#
# == Define: thunderbird::smtpserver
#
# Configure an SMTP server for all Thunderbird users on a system.
#
define thunderbird::smtpserver
(
    $host,
    $port = 587,
    $try_ssl = 2,
    $auth_method = 1,
    $description = 'No description'
)
{

    include os::params
    include thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-smtpserver.js-${id}":
        target => 'thunderbird-syspref.js',
        content => template('thunderbird/smtpserver.js.erb'),
        owner => $::os::params::adminuser,
        group => $::os::params::admigroup,
        mode => $::thunderbird::params::file_perms,
    }
}
