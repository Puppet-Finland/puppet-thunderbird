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
#   Keep local copies of emails on this account. Valid values are true and 
#   false.
#
define thunderbird::serverlogin
(
    String  $system_username,
    String  $server,
    String  $server_name,
    String  $server_realusername,
    String  $server_username,
    Boolean $offline_download
)
{
    include ::thunderbird::params

    $id = $title

    $offline_download_str = bool2str($offline_download)

    concat::fragment { "thunderbird-user.js-${system_username}-serverlogin-${id}":
        target  => "thunderbird-user.js-${system_username}",
        content => template('thunderbird/serverlogin.js.erb'),
    }
}
