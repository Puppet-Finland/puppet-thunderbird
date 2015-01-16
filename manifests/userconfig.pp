define thunderbird::userconfig
(
    $username,
    $email,
    $account = $title,
    $identities = $title,
    $server,
    $server_name = $server,
    $server_username = $email,
    $server_realusername = $email,
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
}
