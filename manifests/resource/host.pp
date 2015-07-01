# == Define: nagios::resource::host
#
# Defines a nagios::resource::host and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for a nagios_host call. This will be
#   attached to the resource $name (which should be the $::fqdn) in a
#   create_resources configuration and then create_resources will build
#   an @@nagios_host object
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
define nagios::resource::host (
  $resourcedef,
) {
  validate_hash($resourcedef)

  $_myresources = hash([$name, $resourcedef])
  create_resources('@@nagios_host', $_myresources)
}
