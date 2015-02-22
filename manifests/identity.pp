#
# == Define: thunderbird::identity
#
# Configure a user identity
#
# == Parameters
#
# [*system_username*]
#   User's system username.
# [*fullname*]
#   User's full name, e.g. "John Doe".
# [*organization*]
#   The organization this user/identity belongs to.
# [*smtpserver*]
#   The SMTP server this user/identity users.
# [*useremail*]
#   The email address of this user/identity.
#
define thunderbird::identity
(
    $system_username,
    $fullname,
    $organization,
    $smtpserver,
    $useremail
)
{

    include thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-user.js-${system_username}-identity-${id}":
        target => "thunderbird-user.js-${system_username}",
        content => template('thunderbird/identity.js.erb'),
        owner => $system_username,
        mode => $::thunderbird::params::file_perms,
    }
}
