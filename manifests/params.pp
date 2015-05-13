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

            $global_config = $::hardwaremodel ? {
                'x86_64' => '/usr/lib64/thunderbird/defaults/pref/syspref.js',
                'i686'   => '/usr/lib/thunderbird/defaults/pref/syspref.js',
                default  => '/usr/lib/thunderbird/defaults/pref/syspref.js',
            }
            $file_perms = 644
            $dir_perms = 755
        }
        'Debian': {
            $package_provider = undef
            $file_perms = 644
            $dir_perms = 755
 
            case $::operatingsystem {
                'Debian': {
                    $global_config = '/etc/icedove/pref/syspref.js'
                    $package_name = 'icedove'
                    $package_name_locale = 'icedove-l10n'
                }
                'Ubuntu': {
                    $global_config = '/etc/thunderbird/syspref.js'
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
            $global_config = "C:\\Program Files (x86)\\Mozilla Thunderbird\\defaults\\pref\\syspref.js"
            $file_perms = undef
            $dir_perms = undef
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
