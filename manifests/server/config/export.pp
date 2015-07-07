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
  $localcommands,
  $localcommanddefaults,
  $localcontacts,
  $localcontactdefaults,
  $localcontactgroups,
  $localcontactgroupdefaults,
  $nagiostag,
  $templatecontact,
  $templatehost,
  $templateservice,
  $templatetimeperiod,
) {
  validate_hash($defaultcommands)
  validate_hash($defaultcontacts)
  validate_hash($defaultcontactgroups)
  validate_hash($localcommands)
  validate_hash($localcommanddefaults)
  validate_hash($localcontacts)
  validate_hash($localcontactdefaults)
  validate_hash($localcontactgroups)
  validate_hash($localcontactgroupdefaults)
  validate_string($nagiostag)
  validate_hash($templatecontact)
  validate_hash($templatehost)
  validate_hash($templateservice)
  validate_hash($templatetimeperiod)

  # We need some variables out of nagios::params
  include nagios::params

  # build out needed templates
  create_resources('nagios::resource', $templatecontact, {
    'type'             => 'contact',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $templatehost, {
    'type'             => 'host',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $templateservice, {
    'type'             => 'service',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $templatetimeperiod, {
    'type'             => 'timeperiod',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  # setup the default commands
  create_resources('nagios::resource', $defaultcommands, {
    'type'             => 'command',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $defaultcontacts, {
    'type'             => 'contact',
    defaultresourcedef => {},
    nagiostag          =>  $nagiostag,
  })

  create_resources('nagios::resource', $defaultcontactgroups, {
    'type'             => 'contactgroup',
    defaultresourcedef => {},
    nagiostag          => $nagiostag,
  })

  # site local commands
  create_resources('nagios::resource', $localcommands, {
    'type'             => 'command',
    defaultresourcedef => $localcommanddefaults,
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $localcontacts, {
    'type'             => 'contact',
    defaultresourcedef => $localcontactdefaults,
    nagiostag          => $nagiostag,
  })

  create_resources('nagios::resource', $localcontactgroups, {
    'type'             => 'contactgroup',
    defaultresourcedef => $localcontactgroupdefaults,
    nagiostag          => $nagiostag,
  })
}
