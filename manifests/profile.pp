#
# == Define: thunderbird::profile
#
# Create a Mozilla Thunderbird profile for a user. The profile name is hardcoded 
# to keep things manageable.
#
# == Parameters
#
# [*username*]
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
    $username = $title,
    $accounts,
    $defaultaccount
)
{
    include os::params
    include thunderbird::params

    # The profile name is hardcoded for now for simplicity.
    $profilename = "puppet-${::fqdn}.default"

    if $osfamily == "windows" {
        $local_config_dir = "${::os::params::home_bs}\\${username}\\AppData\\Local\\Thunderbird" 
        $roaming_config_dir = "${::os::params::home_bs}\\${username}\\AppData\\Roaming\\Thunderbird" 
        $profiles_dir = "${roaming_config_dir}\\Profiles"
        $profile_dir = "${profiles_dir}\\${profilename}"
        $profiles_ini = "${roaming_config_dir}\\profiles.ini"
        $profile_path = "Profiles/${profilename}"
        $user_js = "${profile_dir}\\user.js"

        file { "thunderbird-local_config_dir-${username}":
            name => $local_config_dir,
            ensure => directory,
            owner => $username,
        }

        file { "thunderbird-roaming_config_dir-${username}":
            name => $roaming_config_dir,
            ensure => directory,
            owner => $username,
        }

    } else {
        $config_dir = "${::os::params::home}/${username}/.thunderbird"
        $profiles_dir = "${config_dir}"
        $profile_dir = "${profiles_dir}/${profilename}"
        $profiles_ini = "${profiles_dir}/profiles.ini"
        $profile_path = "${profilename}"
        $user_js = "${profile_dir}/user.js"
    }

    # Create user's profiles directory
    file { "thunderbird-profiles-${username}":
        name => $profiles_dir,
        ensure => directory,
        owner => $username,
        mode => $::thunderbird::params::dir_perms,
    }

    # Create user's profile.ini
    file { "thunderbird-profiles.ini-${username}":
        name => "${profiles_ini}",
        content => template('thunderbird/profiles.ini.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
        require => File["thunderbird-profiles-${username}"],
    }

    # Create a directory for this particular profile
    file { "thunderbird-profile-${username}-${profilename}":
        name => "${profile_dir}",
        ensure => directory,
        owner => $username,
        mode => $::thunderbird::params::dir_perms,
        require => File["thunderbird-profiles-${username}"],
    }

    # Create the user.js file that overrides any settings in prefs.js on startup
    concat { "thunderbird-user.js-${username}":
        path => "${user_js}",
        ensure => present,
        owner => $username,
        warn => true,
        mode => $::thunderbird::params::file_perms,
        require => File["thunderbird-profile-${username}-${profilename}"],
    }

    concat::fragment { "thunderbird-user.js-${username}-accountmananager":
        target => "thunderbird-user.js-${username}",
        content => template('thunderbird/accountmanager.js.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
    }
}
