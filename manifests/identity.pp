#
# == Define: thunderbird::identity
#
# Configure a user identity
#
define thunderbird::identity
(
    $username,
    $fullname,
    $organization,
    $smtpserver,
    $useremail
)
{

    include os::params
    include thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-user.js-${username}-identity-${id}":
        target => "thunderbird-user.js-${username}",
        content => template('thunderbird/identity.js.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
    }
}
