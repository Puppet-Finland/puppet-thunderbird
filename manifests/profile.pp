#
# == Define: thunderbird::profile
#
# Create a Mozilla Thunderbird profile for a user. The profile name is hardcoded 
# to keep things manageable.
#
# == Parameters
#
# [*system_username*]
#   User's system username. Affects the location of the profile files. Defaults 
#   to resources $title.
# [*accounts*]
#   A comma-separated list (with no spaces) of accounts to activate for this 
#   profile. See thunderbird::account for details.
# [*defaultaccount*]
#   The default account (to show on startup).
#
define thunderbird::profile
(
    $system_username = $title,
    $accounts,
    $defaultaccount
)
{
    include os::params
    include thunderbird::params

    # The profile name is hardcoded for now for simplicity.
    $profilename = "puppet-${::fqdn}.default"

    if $osfamily == "windows" {
        $thunderbird_dir = "${::os::params::home_bs}\\${system_username}\\AppData\\Roaming\\Thunderbird"
        $profiles_dir = "${thunderbird_dir}\\Profiles"
        $profile_dir = "${profiles_dir}\\${profilename}"
        $profiles_ini = "${thunderbird_dir}\\profiles.ini"
        $profile_path = "Profiles/${profilename}"
        $user_js = "${profile_dir}\\user.js"

        file { [ $thunderbird_dir,
                 $profiles_dir,
                 $profile_dir ]:
            ensure => directory,
            owner => $system_username,
            mode => $::thunderbird::params::dir_perms,
        }

    } else {

        if $::operatingsystem == "Debian" {
            $thunderbird_dir = "${::os::params::home}/${system_username}/.icedove"
        } else {
            $thunderbird_dir = "${::os::params::home}/${system_username}/.thunderbird"
        }
        $profiles_dir = "${thunderbird_dir}"
        $profile_dir = "${profiles_dir}/${profilename}"
        $profiles_ini = "${profiles_dir}/profiles.ini"
        $profile_path = "${profilename}"
        $user_js = "${profile_dir}/user.js"

        file { [ $thunderbird_dir,
                 $profile_dir ]:
            ensure => directory,
            owner => $system_username,
            mode => $::thunderbird::params::dir_perms,
        }
    }

    # Create user's profile.ini
    file { "thunderbird-profiles.ini-${system_username}":
        name => "${profiles_ini}",
        content => template('thunderbird/profiles.ini.erb'),
        owner => $system_username,
        mode => $::thunderbird::params::file_perms,
        require => File[$profile_dir],
    }

    # Create the user.js file that overrides any settings in prefs.js on startup
    concat { "thunderbird-user.js-${system_username}":
        path => "${user_js}",
        ensure => present,
        owner => $system_username,
        warn => true,
        mode => $::thunderbird::params::file_perms,
        require => File[$profile_dir],
    }

    concat::fragment { "thunderbird-user.js-${system_username}-accountmananager":
        target => "thunderbird-user.js-${system_username}",
        content => template('thunderbird/accountmanager.js.erb'),
        owner => $system_username,
        mode => $::thunderbird::params::file_perms,
    }
}
