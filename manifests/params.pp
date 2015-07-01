class nagios::params {
  # default address to use
#  $address       = $::ipaddress
#  $check_command = 'check-host-alive'
#  $hostgroups    = [
#      'Other'
#    ]
#  $host_use = 'generic-host'

  $defaulthostconfig     = {
    'address'            => $::ipaddress,
    'alias'              => $::hostname,
    'check_command'      => 'check-host-alive',
    'check_interval'     => '5',
    'ensure'             => 'present',
    'host_name'          => $::fqdn,
    'hostgroups'         => [$::operatingsystem],
    'max_check_attempts' => '3',
    'retry_interval'     => '1',
    'use'                => 'generic-host',
  }

  $defaultserviceconfig  = {
    'check_interval'     => '5',
    'ensure'             => 'present',
    'host_name'          => $::fqdn,
    'max_check_attempts' => '3',
    'retry_interval'     => '1',
    'use'                => 'generic-service',
  }

  $basename = $::osfamily ? {
    'Debian' => 'nagios3',
    'RedHat' => 'nagios',
  }

  $user1 = $::osfamily ? {
    'Debian'   => '/usr/lib/nagios/plugins',
    'RedHat'   => $::architecture ? {
      'x86_64' => '/usr/lib64/nagios/plugins',
      default  => '/usr/lib/nagios/plugins',
    },
  }

  $rootdir     = "/etc/${basename}"
  $resourcedir = "${rootdir}/objects"

  # default list of plugins to install
  # only define nagios-plugins-all by default as that will pull in all
  # nagios plugins. If the server should only have select plugins
  # installed they will need to be individually specified.
  $plugins = [
      'nagios-plugins-all'
    ]
}
