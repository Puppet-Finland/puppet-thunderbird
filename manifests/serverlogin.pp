#
# == Define: thunderbird::serverlogin
#
# Set up login details for a particular user and a particular IMAP/POP server.
#
# == Parameters
#
# [*username*]
#   User's system username.
# [*server*]
#   The server identifier to bind this login information with. See 
#   thunderbird::server for details.
# [*server_name*]
#   The server's display name in Thunderbird.
# [*server_realusername*]
#   User's login name on the IMAP/POP server. Possibly redundant, but seems to 
#   get set.
# [*server_username*]
#   User's login name on the IMAP/POP server. Possibly redundant, but seems to 
#   get set.
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

    $id = $title

    concat::fragment { "thunderbird-user.js-${username}-serverlogin-${id}":
        target => "thunderbird-user.js-${username}",
        content => template('thunderbird/serverlogin.js.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
    }
}
