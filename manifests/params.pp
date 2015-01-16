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
            $source_permissions = undef
        }
        'Debian': {
            $package_provider = undef
            $global_config = '/etc/thunderbird/syspref.js'
            $file_perms = 644
            $dir_perms = 755
            $source_permissions = undef
 
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
            $source_permissions = undef
        }
        'Windows': {
            $package_provider = 'chocolatey'
            $package_name = 'thunderbird'
            $global_config = "C:\\Program Files (x86)\\Mozilla Thunderbird\\defaults\\pref\\syspref.js"
            $file_perms = undef
            $dir_perms = undef
            $source_permissions = ignore
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
