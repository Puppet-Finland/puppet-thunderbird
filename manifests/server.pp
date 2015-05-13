#
# == Define: thunderbird::server
#
# Configure an IMAP/POP server for all Thunderbird users on a system.
#
# == Parameters
#
# [*host*]
#   IMAP/POP server's hostname.
# [*port*]
#   IMAP/POP server's port. Defaults to 993.
# [*type*]
#   Server type. Defaults to 'imap'. Valid values currently unknown.
# [*sockettype*]
#   Determines the type of security to use. Defaults to 3. Valid values 
#   currently unknown.
# [*is_gmail*]
#   Determines if the server is a Gmail server. Possibly affects how folders are 
#   managed. Valid values 'true' and 'false' (default).
#
define thunderbird::server
(
    $host,
    $port = 993,
    $type = 'imap',
    $sockettype = 3,
    $is_gmail = false
)
{

    include ::thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-server.js-${id}":
        target  => 'thunderbird-syspref.js',
        content => template('thunderbird/server.js.erb'),
    }
}
