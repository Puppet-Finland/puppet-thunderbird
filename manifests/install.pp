# == Class: thunderbird::install
#
# This class installs Mozilla Thunderbird
#
class thunderbird::install inherits thunderbird::params {

    package { $::thunderbird::params::package_name:
        ensure   => installed,
        provider => $::os::params::package_provider,
        require  => $thunderbird::params::package_require,
    }
}
