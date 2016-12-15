# == Define: nagios::resource::command
#
# Defines a nagios::resource::command and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_command call. This will be
#   used in the creation of the exported nagios_command object
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
define nagios::resource::command (
  $resourcedef,
) {
  validate_hash($resourcedef)

  @@nagios_command { $name:
    * => $resourcedef,
  }
}
