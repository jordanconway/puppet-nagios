# == Define: nagios::resource::hostextinfo
#
# Defines a nagios::resource::hostextinfo and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_hostextinfo call. This will be
#   used in the creation of the exported nagios_hostextinfo object
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
define nagios::resource::hostextinfo (
  $resourcedef,
) {
  validate_hash($resourcedef)

  # host extinfo must always be tied to a host. Set $::fqdn as that
  # if it isn't already defined
  $resourcemerge = {
    'host_name' => $::fqdn,
  }

  $_mergedef = merge($resourcemerge, $resourcedef)

  @@nagios_hostextinfo { $name:
    * => $_mergedef,
  }
}
