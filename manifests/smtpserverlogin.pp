#
# == Define: thunderbird::smtpserverlogin
#
# Set up login details for a particular user and a particular SMTP server.
#
# == Paramaters
#
# [*system_username*]
#   User's system username.
# [*smtpserver*]
#   The SMTP server identifier to bind this login information with. See 
#   thunderbird::smtpserver for more information.
# [*smtpserver_username*]
#   User's login name on the SMTP server.
#
define thunderbird::smtpserverlogin
(
    $system_username,
    $smtpserver,
    $smtpserver_username,
)
{
    include ::thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-user.js-${system_username}-smtpserverlogin-${id}":
        target  => "thunderbird-user.js-${system_username}",
        content => template('thunderbird/smtpserverlogin.js.erb'),
    }
}
