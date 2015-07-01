# == Define: nagios::resource::servicegroup
#
# Defines a nagios::resource::servicegroup and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_servicegroup call. This
#   will be attached to the resource $name in a create_resources
#   configuration and then create_resources will build a
#   @@nagios_servicegroup object
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

  $_myresources = hash([$name, $resourcedef])
  create_resources('@@nagios_servicegroup', $_myresources)
}
