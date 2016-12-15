# == Define: nagios::resource::hostgroup
#
# Defines a nagios::resource::hostgroup and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_hostgroup call. This will be
#   used in the creation of the exported nagios_hostgroup object
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
define nagios::resource::hostgroup (
  $resourcedef,
) {
  validate_hash($resourcedef)

  @@nagios_hostgroup { $name:
    * => $resourcedef,
  }
}
