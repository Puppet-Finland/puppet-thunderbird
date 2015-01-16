#
# == Define: thunderbird::userconfig
#
# A wrapper for simplifying Thunderbird email account setup for users.
#
# == Parameters
#
# [*username*]
#   User's system username. Affects file paths.
# [*email*]
#   Email address for this email account. This is reused in many places as a 
#   default value.
# [*fullname*]
#   User's full name. For example 'John Doe'.
# [*organization*]
#   User's organization. Defaults to empty string.
# [*account*]
#   The name of this account. Defaults to $title, which is usually ok.
# [*identity*]
#   The identity name. Defaults to $title, which is usually ok. Only one 
#   identity per account is currently supported.
# [*identities*]
#   The identities to bind to this account. The default value is $title.
# [*server*]
#   The identifier (not hostname) of the IMAP/POP server defined in 
#   thunderbird::server that this account uses.
# [*smtpserver*]
#   The identifier (not hostname) of the SMTP server defined in 
#   thunderbird::smtpserver that this account uses.
# [*server_name*]
#   The user-visible IMAP/POP server name in Thunderbird. Defaults to $email, 
#   which is probably ok in most cases.
# [*server_username*]
#   Login name for the IMAP/POP server. Defaults to $email.
# [*server_realusername*]
#   Real username for the IMAP/POP server. Defaults to $email, but with Gmail 
#   this should be set to $email minus the domain part (e.g. "john.doe").
# [*smtpserver*]
#   The identifier (not hostname) of the SMTP server defined in 
#   thunderbird::smtpserver that this account uses.
# [*smtpserver_username*] 
#   Login name for the SMTP server. Defaults to $email.
#
define thunderbird::userconfig
(
    $username,
    $email,
    $fullname,
    $organization = '',
    $account = $title,
    $identity = $title,
    $identities = $title,
    $server,
    $server_name = $email,
    $server_username = $email,
    $server_realusername = $email,
    $smtpserver,
    $smtpserver_username = $email
)
{
    thunderbird::account { $account:
        username => $username,
        server => $server,
        identities => $identities,
        tag => 'thunderbird',
    }

    thunderbird::serverlogin { $server:
        username => $username,
        server => $server,
        server_username => $server_username,
        server_realusername => $server_realusername,
        server_name => $server_name,
    }

    thunderbird::smtpserverlogin { $smtpserver:
        username => $username,
        smtpserver => $smtpserver,
        smtpserver_username => $smtpserver_username,
    }

    thunderbird::identity { $identity:
        username => $username,
        fullname => $fullname,
        organization => $organization,
        smtpserver => $smtpserver,
        useremail => $email,
    }
}
