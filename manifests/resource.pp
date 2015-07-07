# == Define: nagios::resource
#
# Defines a nagios::resource and calls the appropriate
# nagios::resource::${type} to configure it
#
# === Parameters
#
# [*defaultresourcedef*]
#   Resource defaults that should be merged into the resource
#   definition. Values that exist in both will take the resource
#   definition itself.
#
#   Type: hash
#   Default: {}
#
# [*nagiostag*]
#   The tag value that should be used for resource export / collection
#   by the target nagios server
#
#   Type: string
#   Default: ''
#
# [*resourcedef*]
#   Array containing the definition options for the given resource. The
#   following resource options should always be left alone:
#
#   target (this will be calculated)
#
#   ensure (this is always present as we auto-purge resources not
#   collected)
#   
#   group
#
#   mode
#
#   owner
#
#   Type: hash
#   Default: {}
#
# === Variables
#
# [*type*]
#   What type of resource is being created
#   Type: string
#   This is required
#
#   Options: Any valid puppet nagios resource
#
# === Examples
#
# === Authors
#
# Andrew J Grimberg <agrimberg@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Andrew J Grimberg
#
define nagios::resource (
  $type,
  $defaultresourcedef = {},
  $nagiostag          = '',
  $resourcedef        = {},
) {
  # we need some values from nagios::params (which we would use for an
  # inherit but you can't inherit with defines
  include nagios::params

  validate_hash($defaultresourcedef)
  validate_string($nagiostag)
  validate_hash($resourcedef)

  # determine what our target filename should be
  $name_down = downcase(regsubst($name, '\s+', '_'))
  $target = "${nagios::params::resourcedir}/${type}_${::fqdn}_${name_down}.cfg"

  $_nagiostag = $nagiostag ? {
    ''      => undef,
    default => $nagiostag,
  }

  # Due to how nagios_* resources don't actually create File resources with
  # their target, we're going to export a File resource of the target
  @@file { $target:
    ensure => file,
    tag    => $_nagiostag,
  }

  $mergedef = {
    ensure => 'present',
    target => $target,
    tag    => $_nagiostag,
  }

  $_resourcedef = merge($defaultresourcedef, $resourcedef, $mergedef)

  case $type {
    command: {
      nagios::resource::command { $name:
        resourcedef => $_resourcedef,
      }
    }
    contact: {
      nagios::resource::contact { $name:
        resourcedef => $_resourcedef,
      }
    }
    contactgroup: {
      nagios::resource::contactgroup { $name:
        resourcedef => $_resourcedef,
      }
    }
    host: {
      nagios::resource::host { $name:
        resourcedef => $_resourcedef,
      }
    }
    hostdependency: {
      nagios::resource::hostdependency { $name:
        resourcedef => $_resourcedef,
      }
    }
    hostescalation: {
      nagios::resource::hostescalation { $name:
        resourcedef => $_resourcedef,
      }
    }
    hostextinfo: {
      nagios::resource::hostextinfo { $name:
        resourcedef => $_resourcedef,
      }
    }
    hostgroup: {
      nagios::resource::hostgroup { $name:
        resourcedef => $_resourcedef,
      }
    }
    service: {
      nagios::resource::service { $name:
        resourcedef => $_resourcedef,
      }
    }
    servicedependency: {
      nagios::resource::servicedependency { $name:
        resourcedef => $_resourcedef,
      }
    }
    serviceescalation: {
      nagios::resource::serviceescalation { $name:
        resourcedef => $_resourcedef,
      }
    }
    serviceextinfo: {
      nagios::resource::serviceextinfo { $name:
        resourcedef => $_resourcedef,
      }
    }
    servicegroup: {
      nagios::resource::servicegroup { $name:
        resourcedef => $_resourcedef,
      }
    }
    timeperiod: {
      nagios::resource::timeperiod { $name:
        resourcedef => $_resourcedef,
      }
    }
    default: {
      # normally we would do a validate_re but for some reason the regex
      # doesn't want to work correctly
      fail("Unknown resource type passed of '${type}'")
    }
  }
}
