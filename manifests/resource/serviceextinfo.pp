# == Define: nagios::resource::serviceextinfo
#
# Defines a nagios::resource::serviceextinfo and configures it
#
# === Variables
#
# [*resourcedef*]
#   The resource configuration for the nagios_serviceextinfo call. This
#   will be attached used in the creation of the exported
#   nagios_serviceextinfo object
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
define nagios::resource::serviceextinfo (
  $resourcedef,
) {
  validate_hash($resourcedef)

  # service extinfo must always be tied to a host. Set $::fqdn as that
  # if it isn't already defined
  $resourcemerge = {
    'host_name' => $::fqdn,
  }

  $_mergedef = merge($resourcemerge, $resourcedef)

  @@nagios_serviceextinfo { $name:
    * => $_mergedef,
  }
}
