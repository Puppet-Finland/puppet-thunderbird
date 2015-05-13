#
# == Define: thunderbird::smtpserver
#
# Configure an SMTP server for all Thunderbird users on a system.
#
# == Parameters
#
# [*host*]
#   SMTP server's hostname.
# [*port*]
#   SMTP server's port. Defaults to 587.
# [*try_ssl*]
#   Determines how to use TLS/SSL. Defaults to 2. Valid values currently 
#   unknown.
# [*auth_method*]
#   Authentication method. Defaults to 1. Valid values currently unknown.
# [*description*]
#   Human-readable description of this SMTP server. Defaults to 'No 
#   description'.
#
define thunderbird::smtpserver
(
    $host,
    $port = 587,
    $try_ssl = 2,
    $auth_method = 1,
    $description = 'No description'
)
{
    include ::thunderbird::params

    $id = $title

    concat::fragment { "thunderbird-smtpserver.js-${id}":
        target  => 'thunderbird-syspref.js',
        content => template('thunderbird/smtpserver.js.erb'),
    }
}
