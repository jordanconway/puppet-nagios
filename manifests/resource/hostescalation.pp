# == Define: nagios::resource::hostescalation
#
# Defines a nagios::resource::hostescalation and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_hostescalation call. This will be
#   attached to the resource $name in a create_resources configuration
#   and then create_resources will build a @@nagios_hostescalation object
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

  $_myresources = hash([$name, $_mergedef])
  create_resources('@@nagios_hostescalation', $_myresources)
}
