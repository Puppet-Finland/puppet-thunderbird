#
# == Define: thunderbird::serverlogin
#
# Set up login details for a particular user and a particular IMAP/POP server.
#
# == Parameters
#
# [*system_username*]
#   User's system username.
# [*server*]
#   The server identifier to bind this login information with. See 
#   thunderbird::server for details.
# [*server_name*]
#   The server's display name in Thunderbird.
# [*server_realusername*]
#   User's login name on the IMAP/POP server.
# [*server_username*]
#   User's login name on the IMAP/POP server. Possibly redundant, but seems to 
#   get set.
# [*offline_download*]
#   Keep local copies of emails on this account.
#
define thunderbird::serverlogin
(
    $system_username,
    $server,
    $server_name,
    $server_realusername,
    $server_username,
    $offline_download
)
{
    include ::thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-user.js-${system_username}-serverlogin-${id}":
        target  => "thunderbird-user.js-${system_username}",
        content => template('thunderbird/serverlogin.js.erb'),
    }
}
