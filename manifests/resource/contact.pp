# == Define: nagios::resource::contact
#
# Defines a nagios::resource::contact and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_contact call. This will be
#   used in the creation of the exported nagios_contact object
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

  @@nagios_contact { $name:
    * => $resourcedef,
  }
}
