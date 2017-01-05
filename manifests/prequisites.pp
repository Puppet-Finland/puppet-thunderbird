# == Class: thunderbird::prequisites
#
# This class setups prequisites for Mozilla Thunderbird
#
class thunderbird::prequisites inherits thunderbird::params {

    if $::kernel == 'windows' {
        include ::chocolatey
    }
}
