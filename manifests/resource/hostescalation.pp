# == Define: nagios::resource::hostescalation
#
# Defines a nagios::resource::hostescalation and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_hostescalation call. This will be
#   used in the creation of the exported nagios_hostescalation object
#   Type: hash
#
# === Authors
#
# Andrew J Grimberg <agrimberg@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Andrew J Grimberg
#
define nagios::resource::hostescalation (
  $resourcedef,
) {
  validate_hash($resourcedef)

  # host escalations must always be tied to a host. Set $::fqdn as that
  # if it isn't already defined
  $resourcemerge = {
    'host_name' => $::fqdn,
  }

  $_mergedef = merge($resourcemerge, $resourcedef)

  @@nagios_hostescalation { $name:
    * => $_mergedef,
  }
}
