#
# == Define: thunderbird::account
#
# Configure an (email)account for a user
#
define thunderbird::account
(
    $username,
    $server,
    $identities
)
{

    include os::params
    include thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-user.js-${username}-account-${id}":
        target => "thunderbird-user.js-${username}",
        content => template('thunderbird/account.js.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
    }
}
