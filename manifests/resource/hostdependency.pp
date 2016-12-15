# == Define: nagios::resource::hostdependency
#
# Defines a nagios::resource::hostdependency and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_hostdependency call. This will be
#   used in the creation of the exported nagios_hostdependency
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
define nagios::resource::hostdependency (
  $resourcedef,
) {
  validate_hash($resourcedef)

  @@nagios_hostdependency { $name:
    * => $resourcedef,
  }
}
