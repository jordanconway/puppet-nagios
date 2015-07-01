# == Define: nagios::resource::timeperiod
#
# Defines a nagios::resource::timeperiod and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_timeperiod call. This will
#   be attached to the resource $name in a create_resources
#   configuration and then create_resources will build a
#   @@nagios_timeperiod object
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

  $_myresources = hash([$name, $resourcedef])
  create_resources('@@nagios_timeperiod', $_myresources)
}
