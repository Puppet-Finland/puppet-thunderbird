#
# == Define: thunderbird::smtpserverlogin
#
# Set up login details for a particular user and a particular SMTP server.
#
# == Paramaters
#
# [*username*]
#   User's system username.
# [*smtpserver*]
#   The SMTP server identifier to bind this login information with. See 
#   thunderbird::smtpserver for more information.
# [*smtpserver_username*]
#   User's login name on the SMTP server.
#
define thunderbird::smtpserverlogin
(
    $username,
    $smtpserver,
    $smtpserver_username,
)
{

    include os::params
    include thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-user.js-${username}-smtpserverlogin-${id}":
        target => "thunderbird-user.js-${username}",
        content => template('thunderbird/smtpserverlogin.js.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
    }
}
