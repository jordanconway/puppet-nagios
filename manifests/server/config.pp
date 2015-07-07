# == Class: nagios::server::config
#
# Configures nagios
#
# === Variables
#
# === Authors
#
# Andrew J Grimberg <agrimberg@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Andrew J Grimberg
#
class nagios::server::config (
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

  anchor { 'nagios::server::config::begin': }
  anchor { 'nagios::server::config::end': }

  class { 'nagios::server::config::export':
    defaultcommands           => $defaultcommands,
    defaultcontacts           => $defaultcontacts,
    defaultcontactgroups      => $defaultcontactgroups,
    defaulthostgroups         => $defaulthostgroups,
    localcommands             => $localcommands,
    localcommanddefaults      => $localcommanddefaults,
    localcontacts             => $localcontacts,
    localcontactdefaults      => $localcontactdefaults,
    localcontactgroups        => $localcontactgroups,
    localcontactgroupdefaults => $localcontactgroupdefaults,
    localhostgroups           => $localhostgroups,
    localhostgroupdefaults    => $localhostgroupdefaults,
    nagiostag                 => $nagiostag,
    templatecontact           => $templatecontact,
    templatehost              => $templatehost,
    templateservice           => $templateservice,
    templatetimeperiod        => $templatetimeperiod,
  }

  class { 'nagios::server::config::import':
    nagiostag => $nagiostag,
  }

  file { 'nagios resourcedir':
    ensure  => directory,
    path    => $nagios::params::resourcedir,
    purge   => true,
    recurse => true,
    before  => Class['nagios::server::config::import'],
  }

  Anchor['nagios::server::config::begin'] ->
    Class['nagios::server::config::export'] ->
    Class['nagios::server::config::import'] ->
  Anchor['nagios::server::config::end']
}
