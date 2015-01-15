#
# == Define: thunderbird::account
#
# Configure an (email)account for a user
#
# == Parameters
#
# [*username*]
#   User's system username.
# [*server*]
#   The server identifier (see thunderbird::server) to tie into this account.
# [*identities*]
#   A comma-separated list (no spaces!) of identities (see 
#   thunderbird::identities) to tie into this account.
#
define thunderbird::account
(
    $username,
    $server,
    $identities
)
{

    include thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-user.js-${username}-account-${id}":
        target => "thunderbird-user.js-${username}",
        content => template('thunderbird/account.js.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
    }
}
