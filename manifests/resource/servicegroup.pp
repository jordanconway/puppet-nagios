# == Define: nagios::resource::servicegroup
#
# Defines a nagios::resource::servicegroup and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_servicegroup call. This
#   will be used in the creation of the exported nagios_servicegroup
#   object
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
define nagios::resource::servicegroup (
  $resourcedef,
) {
  validate_hash($resourcedef)

  @@nagios_servicegroup { $name:
    * => $resourcedef,
  }
}
