# == Class: nagios::client
#
# Basic nagios client definition
#
# === Parameters
#
# [*baseservices*]
#   Base services that a system should have applied to it. This
#   generally a sitewide configuration and would be done via an APL
#   hiera lookup at a less secific level than the host itself.
#
#   The format of the hash is as follows and is similar for all of the
#   various resource types, with the exception of the default* types
#
#   $baseservices = {
#     'service-name'                     => {
#       'resourcedef'                    => {
#         'nagios_service_variable_name' => 'nagios_service variable value'
#       }
#     }
#   }
#
#   Type: hash
#   Default: {}
#
# [*defaulthostconfig*]
#   The default nagios_host configuration. This is combined with the
#   information from $hostconfig (with $hostconfig overriding any values
#   that are defined in this) to fully create the nagios_host
#   configuration
#
#   Unlike the all of the default* definitions use a format that is
#   similar to the $baseservices defintion except they do away with the
#   top two layers and only deal with the inner most hash (which would
#   be the 'resourcedef' layer)
#
#   $defaulthostconfig = {
#     'nagios_host_variable_name' => 'nagios_host variable value',
#   }
#
#   Type: hash
#   Default: see $nagios::params::defaulthostconfig
#
# [*defaulthostdependencies*]
#   The default host dependencies that are combined with
#   $hostdependencies
#
#   Type: hash
#   Default: {}
#
# [*defaulthostextinfo*]
#   The default host extinfo that is combined with $hostextinfo
#
#   Type: hash
#   Default: see $nagios::params::defaulthostextinfo
#
# [*defaultserviceconfig*]
#   The default service options that are combined with $hostservices as
#   well as $baseservices
#
#   Type: hash
#   Default: see $nagios::params::defaultserviceconfig
#
# [*defaultservicedependencies*]
#   The default service dependencies that are combined with
#   $hostservicedependencies
#
#   Type: hash
#   Default: {}
#
# [*defaultserviceescalation*]
#   The default service escalation that is combined with
#   $hostserviceescalation
#
#   Type: hash
#   Default: see $nagios::params::defaultserviceescalation
#
# [*defaultserviceextinfo*]
#   The default service extinfo that is combined with
#   $hostserviceextinfo
#
#   Type: hash
#   Default: see $nagios::params::defaultserviceextinfo
#
# [*hostconfig*]
#   The nagios_host configuraiton that is combined with
#   $defaulthostconfig.
#
#   Type: hash
#   Default: {}
#
# [*hostdependencies*]
#   The nagios_hostdependencies that is combined with
#   $defaulthostdependencies
#
#   Type: hash
#   Default: {}
#
# [*hostextinfo*]
#   The nagios_hostextinfo that is combined with $defaulthostextinfo
#
#   Type: hash
#   Default: {}
#
# [*hostservices*]
#   The nagios_service definitions specific to this host. This is
#   combined with $defaultserviceconfig
#
#   Type: hash
#   Default: {}
#
# [*hostservicedependencies*]
#   The nagios_servicedepency defintions specific to this host. This is
#   combined with $defaultservicedependencies
#
#   Type: hash
#   Default: {}
#
# [*hostserviceescalation*]
#   The nagios_serviceescalation definitions specific to this host. This
#   is combined with $defaultserviceescalation
#
#   Type: hash
#   Default: {}
#
# [*hostserviceextinfo*]
#   The nagios_serviceextinfo definitions specific to this host. This is
#   combined with $defaultserviceextinfo
#
#   Type: hash
#   Default: {}
#
# [*nagiostag*]
#   The nagios server / tag that will be used for collecting the
#   exported resources.
#
#   Type: string
#   Default: ''
#
# [*plugins*]
#   The plugins that need to be installed on this nagios client
#   (generally for NRPE reasons)
#
#   Type: array
#   Default: []
#
# === Authors
#
# Andrew J Grimberg <agrimberg@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Andrew J Grimberg
#
class nagios::client (
  $baseservices               = {},
  $defaulthostconfig          = $nagios::params::defaulthostconfig,
  $defaulthostdependencies    = {},
  $defaulthostextinfo         = $nagios::params::defaulthostextinfo,
  $defaultserviceconfig       = $nagios::params::defaultserviceconfig,
  $defaultservicedependencies = {},
  $defaultserviceescalation   = $nagios::params::defaultserviceescalation,
  $defaultserviceextinfo      = $nagios::params::defaultserviceextinfo,
  $hostconfig                 = {},
  $hostdependencies           = {},
  $hostextinfo                = {},
  $hostservices               = {},
  $hostservicedependencies    = {},
  $hostserviceescalation      = {},
  $hostserviceextinfo         = {},
  $nagiostag                  = '',
  $plugins                    = [],
) inherits nagios::params {

  validate_hash($baseservices)
  validate_hash($defaulthostconfig)
  validate_hash($defaulthostdependencies)
  validate_hash($defaulthostextinfo)
  validate_hash($defaultserviceconfig)
  validate_hash($defaultservicedependencies)
  validate_hash($defaultserviceescalation)
  validate_hash($defaultserviceextinfo)
  validate_hash($hostconfig)
  validate_hash($hostdependencies)
  validate_hash($hostextinfo)
  validate_hash($hostservices)
  validate_hash($hostservicedependencies)
  validate_hash($hostserviceescalation)
  validate_hash($hostserviceextinfo)
  validate_string($nagiostag)
  validate_array($plugins)

  # We always export a host configuration
  nagios::resource { $::fqdn:
    resource_type      => 'host',
    defaultresourcedef => $defaulthostconfig,
    nagiostag          => $nagiostag,
    resourcedef        => $hostconfig,
  }

  # create any base services
  $baseservices.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'service',
      defaultresourcedef => $defaultserviceconfig,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  # create any host dependencies
  $hostdependencies.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'hostdependency',
      defaultresourcedef => $defaulthostdependencies,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  # create any hostextinfo
  $hostextinfo.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'hostextinfo',
      defaultresourcedef => $defaulthostextinfo,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  # create host specific services
  $hostservices.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'service',
      defaultresourcedef => $defaultserviceconfig,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  # create service dependencies
  $hostservicedependencies.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'servicedependency',
      defaultresourcedef => $defaultservicedependencies,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  # create service escalations
  $hostserviceescalation.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'serviceescalation',
      defaultresourcedef => $defaultservicedependencies,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  # create service extinfo
  $hostserviceextinfo.each |$resource, $options| {
    nagios::resource { $resource:
      resource_type      => 'serviceextinfo',
      defaultresourcedef => $defaultserviceextinfo,
      nagiostag          => $nagiostag,
      *                  => $options,
    }
  }

  # install all specified plugins
  package { $plugins:
    ensure => installed,
  }
}
