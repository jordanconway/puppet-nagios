# == Class: nagios::server::config
#
# Configures nagios
#
# === Variables
#
# [*plugins*]
#   The list of all plugin packages that should be installed on this
#   server. This defaults to nagios-plugins-all which is an EPEL meta
#   package pulling in all nagios plugins.
#
#   NOTE: The nagios::client also has a plugins definition which
#   defaults to empty. If the nagios and nagios::client classes are both
#   defined on a system (which would be expected) then the packages
#   between both the server and client classes need to safely resolve.
#   As such it is recommended to force override the
#   nagios::client::plugins to be an empty array on the nagios server
#
#   Type: array
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

  anchor { 'nagios::server::config::begin': }
  anchor { 'nagios::server::config::end': }

  class { 'nagios::server::config::export':
    defaultcommands           => $defaultcommands,
    defaultcontacts           => $defaultcontacts,
    defaultcontactgroups      => $defaultcontactgroups,
    localcommands             => $localcommands,
    localcommanddefaults      => $localcommanddefaults,
    localcontacts             => $localcontacts,
    localcontactdefaults      => $localcontactdefaults,
    localcontactgroups        => $localcontactgroups,
    localcontactgroupdefaults => $localcontactgroupdefaults,
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
