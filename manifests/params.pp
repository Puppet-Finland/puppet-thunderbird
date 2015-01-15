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
            $global_config = '/etc/thunderbird/syspref.js'
            $file_perms = 644
            $dir_perms = 755
        }
        'Debian': {
            $package_provider = undef
            $global_config = '/etc/thunderbird/syspref.js'
            $file_perms = 644
            $dir_perms = 755
 
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
            $global_config = '/etc/thunderbird/syspref.js'
            $file_perms = 644
            $dir_perms = 755
        }
        'Windows': {
            $package_provider = 'chocolatey'
            $package_name = 'thunderbird'
            $global_config = '/etc/thunderbird/syspref.js'
            $file_perms = undef
            $dir_perms = undef
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}