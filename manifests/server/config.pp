# == Class: nagios::server::config
#
# Configures nagios
#
# === Variables
#
# [*conffile*]
#   The configuration file that nagios will write to. This is
#   effectively non-configurable as there is no direct method for a user
#   to set this. See nagios::params for the default value
#
# [*cgiconffile*]
#   The CGI configuration file for Nagios web interface. This is
#   effectively non-configurable as there is no direct method for a user
#   to set this. See nagios::params for the default value
#
# [*defaultcommands*]
#   The default commands to be configured on the system. These are from
#   the EPEL nagios installation and include 2 extra commands
#   notify-{host,service}-by-epager which are similar to the standard
#   notify-{host,service}-by-email except they send a more condensed
#   alert. Please see nagios::params for the definition of all the
#   commands
#
#   The hash definition used by the defaultcommands is the same used for
#   all of the various nagios resources. The format is as follows:
#
#   $somehash = {
#     'resource-name'                => {
#       'resourcedef'                => {
#         'nagios_resource_variable' => 'nagios resource variable value',
#       },
#     },
#   }
#
#   Type: hash
#   Default: see $nagios::params::defaultcommands
#
# [*defaultcontacts*]
#   The default contacts to be setup on the system. This is the same
#   default contact set that the EPEL nagios installation creates. A
#   single 'nagiosadmin' user which is part of contact group 'admins'
#
#   Type: hash
#   Default: see $nagios::params::defaultcontacts
#
# [*defaultcontactgroups*]
#   The default contact groups that are to be setup on the system. This
#   is the same default that the EPEL nagios installation creates. A
#   single 'admins' group which includes the 'nagiosadmin' contact
#
#   Type: hash
#   Default: see $nagios::params::defaultcontactgroups
#
# [*defaulthostgroups*]
#   The default host groups that are to be setup on the system.
#
# Type: hash
#   Default: see $nagios::params::defaulthostgroups
#
# [*localcommands*]
#   Custom commands that should be added to the system in addition to
#   the defaultcommands. This allows you to take the pre-defined
#   defaults, but also extend the server with your own custom commands.
#   If you wish to modify or change any of the default commands you will
#   need to override the entire defaultcommands set and can then leave
#   this as empty.
#
#   See [*defaultcommands*] for information on the format of the hash
#
#   Type: hash
#   Default: {}
#
# [*localcommanddefaults*]
#   Custom default that should be applied to any commands defined in
#   localcommands.
#
#   Unlike the various resource hash definitions, the defaults
#   definitions do away with two levels in the hash and only deal with
#   the innermost level of the nagios resource variables and their
#   values. An example definition would be as follows:
#
#   $commanddefaults = {
#     'nagios_resource_variable' => 'nagios resource variable value',
#   }
#
#   Type: hash
#   Default: {}
#
# [*localcontacts*]
#   The local contacts to be used on this system apart from the default
#   contacts previously defined.
#
#   Type: hash
#   Default: {}
#
# [*localcontactdefaults*]
#   Custom defaults that should be applied to all localcontacts.
#
#   Type: hash
#   Default: {}
#
# [*localcontactgroups*]
#   The local contact groups to be used on this system apart from the
#   default contact groups previously defined.
#
#   Type: hash
#   Default: {}
#
# [*localcontactgroupdefaults*]
#   Custom defaults that should be applied to localcontactgroups.
#
#   Type: hash
#   Default: {}
#
# [*localhostgroups*]
#   The local host groups that are to be used on this system apart from
#   the default host groups previously defined
#
#   Type: hash
#   Default: {}
#
# [*localhostgroupdefaults*]
#   Custom defaults that should be applied to the localhostgroups.
#
#   Type: hash
#   Default: {}
#
# [*nagios_cfg*]
#   The configuration that gets written into the $conffile. This is a
#   conglomerate hash that utilizes the merge of
#   $nagios::params::base_default_nagios_cfg,
#   $nagios::params::os_default_nagios_cfg and the user supplied hash
#   that was passed to the Class['nagios']
#
#   The cfg_dir and cfg_file options take either a single string or an
#   array. For the full list of options see the params file as well as
#   the nagios documentation as params that are not defined in will not
#   be written to file (some are validly not defined)
#
#   Type: hash
#   Default: see description
#
# [*nagios_cgi_cfg*]
#   The configuration that gets written into the $cgiconffile. This is a
#   conglomerate hash that utilizes the merge of
#   $nagios::params::base_default_cgi_cfg,
#   $nagios::params::os_default_cgi_cfg and the user supplied hash
#   that was passed to the Class['nagios']
#
#   The options that start from autorized_for_* take either a single string
#   or an array. For the full list of options see the params file as well as
#   the nagios documentation as params that are not defined in will not
#   be written to file
#
#   Type: hash
#   Default: see description
#
# [*nagiostag*]
#   The name / tag that this server uses to both export the resources
#   for itself as well as to collect all the resources exported by
#   nagios::clients
#
#   Type: string
#   Default: $::fqdn
#
# [*resource_macros*]
#   An array listing the values for the $USER1$ style resource macros.
#   The array order itself will determine which $USER<NUM>$ the macro
#   receives.
#
#   Type: array
#   Default: One array member setting $USER1$ = the nagios plugins path
#
#   RH x86_64 systems would end up as [ '/usr/lib64/nagios/plugins' ]
#
#   NOTE: The default params array is _not_ merged with a user supplied
#   array, as such, if adding macros you should make sure that you set
#   the plugins macro (normal default is for $USER1$)
#
# [*templatecontact*]
#   The default template definition(s) for contacts. These are taken
#   from the EPEL nagios installation.
#
#   Type: hash
#   Default: see $nagios::params::templatecontact
#
# [*templatehost*]
#   The default template definition(s) for hosts. These are taken from
#   the EPEL nagios installation.
#
#   Type: hash
#   Default: see $nagios::params::templatehost
#
# [*templateservice*]
#   The default template definition(s) for services. These are taken
#   from the EPEL nagios installation.
#
#   Type: hash
#   Default: see $nagios::params::templateservice
#
# [*templatetimeperiod*]
#   The default timeperiod definition(s). These are taken from the EPEL
#   nagios installation with the exception of the negative us-holidays
#   template as the nagios_timeperiod puppet resource does not
#   understand how to handle the nagios exception definitions
#
#   Type: hash
#   Default: see $nagios::params::templatetimeperiod
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
  $conffile,
  $cgiconffile,
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
  $nagios_cfg,
  $nagios_cgi_cfg,
  $nagiostag,
  $resource_macros,
  $templatecontact,
  $templatehost,
  $templateservice,
  $templatetimeperiod,
) {
  validate_absolute_path($conffile)
  validate_absolute_path($cgiconffile)
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
  validate_hash($nagios_cfg)
  validate_hash($nagios_cgi_cfg)
  validate_string($nagiostag)
  validate_array($resource_macros)
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

  # nagios config file
  # FIXME: we should be validating all of the currently known variables
  # with the allowed settings types. Given how many there and that we're
  # trying to get this up and running in use, we're going to just leave
  # that for now and the validate_hash done previously will have to do
  # currently.

  file { $conffile:
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template('nagios/nagios.cfg.erb')
  }

  file { $cgiconffile:
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template('nagios/cgi.cfg.erb'),
  }

  validate_absolute_path($nagios_cfg['resource_file'])
  validate_string($nagios_cfg['nagios_group'])

  # make sure that private macro resource directory exists
  $private_res_dir = dirname($nagios_cfg['resource_file'])
  file { $private_res_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => $nagios_cfg['nagios_group'],
    mode   => '0750',
  }

  # private macro resource file
  file { $nagios_cfg['resource_file']:
    owner   => 'root',
    group   => $nagios_cfg['nagios_group'],
    mode    => '0640',
    content => template('nagios/private_resource.cfg.erb')
  }

  Anchor['nagios::server::config::begin'] ->
    Class['nagios::server::config::export'] ->
    Class['nagios::server::config::import'] ->
  Anchor['nagios::server::config::end']
}
