#
# == Define: thunderbird::userconfig
#
# A wrapper for simplifying Thunderbird email account setup for users.
#
# == Parameters
#
# [*system_username*]
#   User's system username. Affects file paths.
# [*email*]
#   Email address for this email account. This is reused in many places as a 
#   default value.
# [*fullname*]
#   User's full name. For example 'John Doe'.
# [*server*]
#   The identifier (not hostname) of the IMAP/POP server defined in 
#   thunderbird::server that this account uses.
# [*smtpserver*]
#   The identifier (not hostname) of the SMTP server defined in 
#   thunderbird::smtpserver that this account uses.
# [*organization*]
#   User's organization. Defaults to empty string.
# [*account*]
#   The name of this account. Defaults to $title, which is usually ok.
# [*identity*]
#   The identity name. Defaults to $title, which is usually ok. Only one 
#   identity per account is currently supported.
# [*identities*]
#   The identities to bind to this account. The default value is $title.
# [*server_name*]
#   The user-visible IMAP/POP server name in Thunderbird. Defaults to $email, 
#   which is probably ok in most cases.
# [*server_realusername*]
#   Username for the IMAP/POP server. Defaults to $email, but with Gmail for 
#   example this should be set to $email minus the domain part (e.g. 
#   "john.doe").
# [*offline_download*]
#   Keep local copies of emails on this account. Valid values are true (default) 
#   and false.
# [*smtpserver_username*] 
#   Login name for the SMTP server. Defaults to $email.
# [*configure_smtpserver*]
#   Configure a new SMTP server. Setting this to false allows reusing the same 
#   SMTP server for several email accounts. Defaults value is true.
# [*compose_html*]
#   Whether to compose message in HTML or not. Valid values are true (default)
#   and false.
#
define thunderbird::userconfig
(
    $system_username,
    $email,
    $fullname,
    $server,
    $smtpserver,
    $organization = undef,
    $account = $title,
    $identity = $title,
    $identities = $title,
    $server_name = undef,
    $server_realusername = undef,
    $offline_download = true,
    $smtpserver_username = undef,
    $configure_smtpserver = true,
    $compose_html = true
)
{
    validate_bool($configure_smtpserver)

    # After Puppet 4.3.0 class parameters can't default to values of other class 
    # parameters like this:
    #
    #     $server_name = $email
    #
    # So we need to set the default parameters here instead
    #
    $server_name_tmp = $server_name ? {
        undef   => $email,
        default => $server_name,
    }
    $server_realusername_tmp = $server_realusername ? {
        undef   => $email,
        default => $server_realusername,
    }
    $smtpserver_username_tmp = $smtpserver_username ? {
        undef   => $email,
        default => $smtpserver_username,
    }

    thunderbird::account { $account:
        system_username => $system_username,
        server          => $server,
        identities      => $identities,
        tag             => 'thunderbird',
    }

    thunderbird::serverlogin { $server:
        system_username     => $system_username,
        server              => $server,
        server_username     => $server_realusername_tmp,
        server_realusername => $server_realusername_tmp,
        server_name         => $server_name_tmp,
        offline_download    => $offline_download,
    }

    if $configure_smtpserver {
        thunderbird::smtpserverlogin { $smtpserver:
            system_username     => $system_username,
            smtpserver          => $smtpserver,
            smtpserver_username => $smtpserver_username_tmp,
        }
    }

    thunderbird::identity { $identity:
        system_username => $system_username,
        fullname        => $fullname,
        organization    => $organization,
        smtpserver      => $smtpserver,
        useremail       => $email,
        compose_html    => $compose_html,
    }
}
