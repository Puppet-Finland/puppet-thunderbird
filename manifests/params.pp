#
# == Class: thunderbird::params
#
# Defines some variables based on the operating system
#
class thunderbird::params {

    case $::osfamily {
        'RedHat': {
            $package_name = 'thunderbird'
            $package_provider = undef
        }
        'Debian': {
            $package_provider = undef
            case $::operatingsystem {
                'Debian': {
                    $package_name = 'icedove'
                    $package_name_locale = 'icedove-l10n'
                }
                'Ubuntu': {
                    $package_name = 'thunderbird'
                    $package_name_locale = 'thunderbird-locale'
                }
                default: {
                    fail("Unsupported OS: ${::operatingsystem}")
                }
            }
        }
        'FreeBSD': {
            $package_provider = undef
            $package_name = 'thunderbird'
        }
        'Windows': {
            $package_provider = 'chocolatey'
            $package_name = 'thunderbird'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
