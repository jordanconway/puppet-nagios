# == Class: nagios::client
#
# Basic nagios client definition
#
# === Parameters
#
# [*address*]
#   The address that should be used for nagios checks. This defaults to
#   $::ipaddress via $nagios::params::address
#
# [*baseresources*]
#   A resource hash that would be safe to pass to nagios::resource. This
#   is expected to be specified at a common layer in hiera for common
#   checks that all clients in an environment should have
#
# [*check_command*]
#   The command definition to use to check the host is alive. Defaults
#   to 'check-host-alive'
#
# [*extraresources*]
#   A resource hash that would be safe to pass to nagios::resource. This
#   is expected to be any custom checks that this client should have in
#   addition to the baseresources
#
# [*hostgroups*]
#   Array of hostgroups that this client should be part of
#
# [*host_use*]
#   The template to use for the host definition, defaults to
#   'generic-host'
#
# [*nagiostag*]
#   Tag used to identify the nagios server that this client should be
#   exported into
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
#class nagios::client (
#  $address        = $nagios::params::address,
#  $baseresources  = {},
#  $check_command  = $nagios::params::check_command,
#  $extraresources = {},
#  $hostgroups     = $nagios::params::hostgroups,
#  $host_use       = $nagios::params::host_use,
#  $nagiostag      = '',
#  $parents        = []
#) inherits nagios::params {
class nagios::client (
  $baseservices            = {},
  $defaulthostconfig       = $nagios::params::defaulthostconfig,
  $defaultserviceconfig    = $nagios::params::defaultserviceconfig,
  $hostconfig              = {},
  $hostdependencies        = {},
  $hostextinfo             = {},
  $hostservices            = {},
  $hostservicedependencies = {},
  $hostserviceescalation   = {},
  $hostserviceextinfo      = {},
  $nagiostag               = '',
  $plugins                 = [],
) inherits nagios::params {

  validate_hash($baseservices)
  validate_hash($defaulthostconfig)
  validate_hash($defaultserviceconfig)
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
    type               => 'host',
    defaultresourcedef => $defaulthostconfig,
    nagiostag          => $nagiostag,
    resourcedef        => $hostconfig,
  }

  # create any base resource
#  create_resources('nagios::resource', $baseresources, $create_options)

  # create any extra resources
#  create_resources('nagios::resource', $extraresources, $create_options)
}
