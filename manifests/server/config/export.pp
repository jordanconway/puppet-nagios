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

  # build out needed templates
  create_resources('nagios::resource', $templatecontact, {
    'resource_type'    => 'contact',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $templatehost, {
    'resource_type'    => 'host',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $templateservice, {
    'resource_type'    => 'service',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $templatetimeperiod, {
    'resource_type'    => 'timeperiod',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  # setup the default commands
  create_resources('nagios::resource', $defaultcommands, {
    'resource_type'    => 'command',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $defaultcontacts, {
    'resource_type'    => 'contact',
    defaultresourcedef => {},
    nagiostag          =>  $nagiostag,
  })

  create_resources('nagios::resource', $defaultcontactgroups, {
    'resource_type'    => 'contactgroup',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $defaulthostgroups, {
    'resource_type'    => 'hostgroup',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  # site local commands
  create_resources('nagios::resource', $localcommands, {
    'resource_type'    => 'command',
    defaultresourcedef => $localcommanddefaults,
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $localcontacts, {
    'resource_type'    => 'contact',
    defaultresourcedef => $localcontactdefaults,
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $localcontactgroups, {
    'resource_type'    => 'contactgroup',
    defaultresourcedef => $localcontactgroupdefaults,
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $localhostgroups, {
    'resource_type'    => 'hostgroup',
    defaultresourcedef => $localhostgroupdefaults,
    nagiostag          => $nagiostag,
  })
}
