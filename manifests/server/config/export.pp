# == Class: nagios::server::config::export
#
# Configures nagios
#
# === Variables
#
#
# === Authors
#
# Andrew J Grimberg <agrimberg@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Andrew J Grimberg
#
class nagios::server::config::export (
  $defaultcommands,
  $defaultcontacts,
  $defaultcontactgroups,
  $defaulthostgroups,
  $localcommands,
  $localcommanddefaults,
  $localcontacts,
  $localcontactdefaults,
  $localcontactgroups,
  $localcontactgroupdefaults,
  $localhostgroups,
  $localhostgroupdefaults,
  $nagiostag,
  $templatecontact,
  $templatehost,
  $templateservice,
  $templatetimeperiod,
) {
  validate_hash($defaultcommands)
  validate_hash($defaultcontacts)
  validate_hash($defaultcontactgroups)
  validate_hash($defaulthostgroups)
  validate_hash($localcommands)
  validate_hash($localcommanddefaults)
  validate_hash($localcontacts)
  validate_hash($localcontactdefaults)
  validate_hash($localcontactgroups)
  validate_hash($localcontactgroupdefaults)
  validate_hash($localhostgroups)
  validate_hash($localhostgroupdefaults)
  validate_string($nagiostag)
  validate_hash($templatecontact)
  validate_hash($templatehost)
  validate_hash($templateservice)
  validate_hash($templatetimeperiod)

  # We need some variables out of nagios::params
  include nagios::params

  $defoptions = {
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  }

  # build out needed templates
  $templatecontact.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type => 'contact',
      *             => $defoptions + $options,
    }
  }

  $templatehost.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type => 'host',
      *             => $defoptions + $options,
    }
  }

  $templateservice.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type => 'service',
      *             => $defoptions + $options,
    }
  }

  $templatetimeperiod.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type => 'timeperiod',
      *             => $defoptions + $options,
    }
  }

  # setup the default commands
  $defaultcommands.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type => 'command',
      *             => $defoptions + $options,
    }
  }

  $defaultcontacts.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type => 'contact',
      *             => $defoptions + $options,
    }
  }

  $defaultcontactgroups.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type => 'contactgroup',
      *             => $defoptions + $options,
    }
  }

  $defaulthostgroups.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type => 'hostgroup',
      *             => $defoptions + $options,
    }
  }

  # site local commands
  $localcommands.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'command',
      defaultresourcedef => $localcommanddefaults,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  $localcontacts.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'contact',
      defaultresourcedef => $localcontactdefaults,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  $localcontactgroups.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'contactgroup',
      defaultresourcedef => $localcontactgroupdefaults,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  $localhostgroups.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'hostgroup',
      defaultresourcedef => $localhostgroupdefaults,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }
}
