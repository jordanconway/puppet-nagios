# == Define: nagios::resource::host
#
# Defines a nagios::resource::host and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for a nagios_host call. This will be
#   used in the creation of the exported nagios_host object
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

  @@nagios_host { $name:
    * => $resourcedef,
  }
}
