# == Define: nagios::resource::contact
#
# Defines a nagios::resource::contact and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_contact call. This will be
#   attached to the resource $name in a create_resources configuration
#   and then create_resources will build a @@nagios_contact object
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
define nagios::resource::contact (
  $resourcedef,
) {
  validate_hash($resourcedef)

  $name_down = downcase(regsubst($name, '\s+', '_'))

  $_myresources = hash([$name_down, $resourcedef])
  create_resources('@@nagios_contact', $_myresources)
}
