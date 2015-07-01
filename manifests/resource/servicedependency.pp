# == Define: nagios::resource::servicedependency
#
# Defines a nagios::resource::servicedependency and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_servicedependency call.
#   This will be attached to the resource $name in a create_resources
#   configuration and then create_resources will build a
#   @@nagios_servicedependency object
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
define nagios::resource::servicedependency (
  $resourcedef,
) {
  validate_hash($resourcedef)

  $_myresources = hash([$name, $resourcedef])
  create_resources('@@nagios_servicedependency', $_myresources)
}
