# == Define: nagios::resource::service
#
# Defines a nagios::resource::service and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_service call. This will be
#   used in the creation of the exported nagios_service object
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
define nagios::resource::service (
  $resourcedef,
) {
  validate_hash($resourcedef)

  # services must always be tied to a host. Set $::fqdn as that
  # if it isn't already defined
  $resourcemerge = {
    'host_name' => $::fqdn,
  }

  $_mergedef = merge($resourcemerge, $resourcedef)

  @@nagios_service { $name:
    * => $_mergedef,
  }
}
