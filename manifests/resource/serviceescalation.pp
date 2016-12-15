# == Define: nagios::resource::serviceescalation
#
# Defines a nagios::resource::serviceescalation and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_serviceescalation call.
#   This will be used in the creation of the exported
#   @@nagios_serviceescalation object
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
define nagios::resource::serviceescalation (
  $resourcedef,
) {
  validate_hash($resourcedef)

  # service escalations must always be tied to a host. Set $::fqdn as that
  # if it isn't already defined
  $resourcemerge = {
    'host_name' => $::fqdn,
  }

  $_mergedef = merge($resourcemerge, $resourcedef)

  @@nagios_serviceescalation { $name:
    * => $_mergedef,
  }
}
