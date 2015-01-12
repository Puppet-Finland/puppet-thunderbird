# == Class: thunderbird
#
# This class install and configures Mozilla Thunderbird
#
# == Parameters
#
# [*manage*]
#   Manage Mozilla Thunderbird using this module. Valid values 'yes' (default) 
#   and 'no'. This is primarily needed with Hiera where excluding classes 
#   inherited from the lower levels in the hierarchy is not possible.
# [*locales*]
#   A hash of thunderbird::locale resources to realize. Currently only needed on 
#   Debian and Ubuntu where the locales are packaged separately. Defining these 
#   on other operating systems is harmless.
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class thunderbird
(
    $manage = 'yes',
    $locales = {}

) inherits thunderbird::params
{

if $manage == 'yes' {

    include thunderbird::install

    create_resources('thunderbird::locale', $locales)
}
}
