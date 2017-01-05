# == Class: thunderbird::install
#
# This class installs Mozilla Thunderbird
#
class thunderbird::install inherits thunderbird::params {

    $package_require = $::kernel ? {
        'windows' => Class['chocolatey'],
        default   => undef,
    }

    package { $::thunderbird::params::package_name:
        ensure   => installed,
        provider => $::os::params::package_provider,
        require  => $package_require,
    }
}
