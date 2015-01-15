#
# == Define: thunderbird::serverlogin
#
# Set up login details for a particular user and a particular server.
#
define thunderbird::serverlogin
(
    $username,
    $server,
    $server_name,
    $server_realusername,
    $server_username
)
{

    include os::params
    include thunderbird::params

    $id = $server

    concat::fragment { "thunderbird-user.js-${username}-serverlogin-${id}":
        target => "thunderbird-user.js-${username}",
        content => template('thunderbird/serverlogin.js.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
    }
}
