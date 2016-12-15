# == Define: nagios::resource::contactgroup
#
# Defines a nagios::resource::contactgroup and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_contactgroup call. This will be
#   used in the creation of the exported nagios_contactgroup object
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
define nagios::resource::contactgroup (
  $resourcedef,
) {
  validate_hash($resourcedef)

  @@nagios_contactgroup { $name:
    * => $resourcedef,
  }
}
