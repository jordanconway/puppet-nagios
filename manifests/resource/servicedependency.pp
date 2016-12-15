# == Define: nagios::resource::servicedependency
#
# Defines a nagios::resource::servicedependency and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_servicedependency call.
#   This will be used in the creation of the exported
#   nagios_servicedependency object.
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

  @@nagios_servicedependency { $name:
    * => $resourcedef,
  }
}
