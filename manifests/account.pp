#
# == Define: thunderbird::account
#
# Configure an (email)account for a user
#
# == Parameters
#
# [*system_username*]
#   User's system username.
# [*server*]
#   The server identifier (see thunderbird::server) to tie into this account.
# [*identities*]
#   A comma-separated list (no spaces!) of identities (see 
#   thunderbird::identities) to tie into this account.
#
define thunderbird::account
(
    $system_username,
    $server,
    $identities
)
{

    include thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-user.js-${system_username}-account-${id}":
        target => "thunderbird-user.js-${system_username}",
        content => template('thunderbird/account.js.erb'),
        owner => $system_username,
        mode => $::thunderbird::params::file_perms,
    }
}
