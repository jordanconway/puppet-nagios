# == Class: nagios
#
# Defines a nagios server and configures it
#
# === Parameters
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
# [*nagiostag*]
#   The name / tag that this server uses to both export the resources
#   for itself as well as to collect all the resources exported by
#   nagios::clients
#
#   Type: string
#   Default: $::fqdn
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
#   Default: ['nagios-plugins-all']
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
class nagios (
  $defaultcommands           = $nagios::params::defaultcommands,
  $defaultcontacts           = $nagios::params::defaultcontacts,
  $defaultcontactgroups      = $nagios::params::defaultcontactgroups,
  $localcommands             = {},
  $localcommanddefaults      = {},
  $localcontacts             = {},
  $localcontactdefaults      = {},
  $localcontactgroups        = {},
  $localcontactgroupdefaults = {},
  $nagiostag                 = $::fqdn,
  $plugins                   = $nagios::params::plugins,
  $templatecontact           = $nagios::params::templatecontact,
  $templatehost              = $nagios::params::templatehost,
  $templateservice           = $nagios::params::templateservice,
  $templatetimeperiod        = $nagios::params::templatetimeperiod,
) inherits nagios::params {
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
  validate_array($plugins)
  validate_hash($templatecontact)
  validate_hash($templatehost)
  validate_hash($templateservice)
  validate_hash($templatetimeperiod)

  # Install nagios
  package { $nagios::params::basename:
    ensure => present,
  }

  # Install selected plugins
  package { $plugins:
    ensure => present,
  }

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

  # resource collection, collect all the nagios types
  # lint:ignore:storeconfigs
  Nagios_command <<| tag == $nagiostag |>> { }
  Nagios_contactgroup <<| tag == $nagiostag |>> { }
  Nagios_contact <<| tag == $nagiostag |>> { }
  Nagios_hostdependency <<| tag == $nagiostag |>> { }
  Nagios_hostescalation <<| tag == $nagiostag |>> { }
  Nagios_hostextinfo <<| tag == $nagiostag |>> { }
  Nagios_hostgroup <<| tag == $nagiostag |>> { }
  Nagios_host <<| tag == $nagiostag |>> { }
  Nagios_servicedependency <<| tag == $nagiostag |>> { }
  Nagios_serviceescalation <<| tag == $nagiostag |>> { }
  Nagios_serviceextinfo <<| tag == $nagiostag |>> { }
  Nagios_servicegroup <<| tag == $nagiostag |>> { }
  Nagios_service <<| tag == $nagiostag |>> { }
  Nagios_timeperiod <<| tag == $nagiostag |>> { }
  # lint:endignore
}
