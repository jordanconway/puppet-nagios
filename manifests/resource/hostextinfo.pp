# == Define: nagios::resource::hostextinfo
#
# Defines a nagios::resource::hostextinfo and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_hostextinfo call. This will be
#   attached to the resource $name in a create_resources configuration
#   and then create_resources will build a @@nagios_hostextinfo object
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
define nagios::resource::hostextinfo (
  $resourcedef,
) {
  validate_hash($resourcedef)

  # host extinfo must always be tied to a host. Set $::fqdn as that
  # if it isn't already defined
  $resourcemerge = {
    'host_name' => $::fqdn,
  }

  $_mergedef = merge($resourcemerge, $resourcedef)

  $_myresources = hash([$name, $_mergedef])
  create_resources('@@nagios_hostextinfo', $_myresources)
}
