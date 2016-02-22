
# == Class: nagios::server::service
#
# Defines the nagios service
#
# === Parameters
#
# This class accepts no parameters
#
# === Variables
#
# This class accepts no variables
#
# === Authors
#
# Andrew J Grimberg <agrimberg@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Andrew J Grimberg
#
class nagios::server::service {
  include ::nagios::params

  service { 'nagios':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    # lint:ignore:80chars
    restart    => "${nagios::params::basename} -v ${nagios::params::conffile} && service nagios reload",
    # lint:endignore
  }
}
