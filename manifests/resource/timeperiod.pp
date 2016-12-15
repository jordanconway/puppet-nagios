# == Define: nagios::resource::timeperiod
#
# Defines a nagios::resource::timeperiod and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_timeperiod call. This will
#   used in the creation of the exported nagios_timeperiod object
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
define nagios::resource::timeperiod (
  $resourcedef,
) {
  validate_hash($resourcedef)

  @@nagios_timeperiod { $name:
    * => $resourcedef
  }
}
