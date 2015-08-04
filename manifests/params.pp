class nagios::params {
  $defaulthostconfig     = {
    'address'            => $::ipaddress,
    'alias'              => $::hostname,
    'check_command'      => 'check-host-alive',
    'check_interval'     => '5',
    'ensure'             => 'present',
    'host_name'          => $::fqdn,
    'hostgroups'         => ['Other'],
    'max_check_attempts' => '3',
    'retry_interval'     => '1',
    'use'                => 'generic-host',
  }

  $defaulthostextinfo = {
    'host_name' => $::fqdn,
  }

  $defaultserviceconfig  = {
    'check_interval'     => '5',
    'ensure'             => 'present',
    'host_name'          => $::fqdn,
    'max_check_attempts' => '3',
    'retry_interval'     => '1',
    'use'                => 'generic-service',
  }

  $defaultserviceescalation = {
    'host_name' => $::fqdn,
  }

  $defaultserviceextinfo = {
    'host_name' => $::fqdn,
  }

  $basename = $::osfamily ? {
    'Debian' => 'nagios3',
    'RedHat' => 'nagios',
  }

  # base templates and commands
  $templatecontact = {
    'generic-contact'                   => {
      'resourcedef'                     => {
        'host_notification_commands'    => 'notify-host-by-email',
        'host_notification_options'     => 'd,u,r,f,s',
        'host_notification_period'      => '24x7',
        'register'                      => '0',
        'service_notification_commands' => 'notify-service-by-email',
        'service_notification_options'  => 'w,u,c,r,f,s',
        'service_notification_period'   => '24x7',
      },
    },
  }

  $templatehost = {
    'generic-host'                     => {
      'resourcedef'                    => {
        'event_handler_enabled'        => '1',
        'failure_prediction_enabled'   => '1',
        'flap_detection_enabled'       => '1',
        'notification_period'          => '24x7',
        'notifications_enabled'        => '1',
        'process_perf_data'            => '1',
        'register'                     => '0',
        'retain_nonstatus_information' => '1',
        'retain_status_information'    => '1',
      },
    },
    'linux-server'              => {
      'resourcedef'             => {
        'use'                   => 'generic-host',
        'check_period'          => '24x7',
        'check_interval'        => '5',
        'retry_interval'        => '1',
        'max_check_attempts'    => '10',
        'check_command'         => 'check-host-alive',
        'notification_period'   => 'workhours',
        'notification_interval' => '120',
        'notification_options'  => 'd,u,r',
        'contact_groups'        => 'admins',
        'register'              => '0',
      },
    },
    'windows-server'            => {
      'resourcedef'             => {
        'use'                   => 'generic-host',
        'check_period'          => '24x7',
        'check_interval'        => '5',
        'retry_interval'        => '1',
        'max_check_attempts'    => '10',
        'check_command'         => 'check-host-alive',
        'notification_interval' => '30',
        'notification_options'  => 'd,r',
        'contact_groups'        => 'admins',
        'hostgroups'            => 'windows-servers',
        'register'              => '0',
      },
    },
    'generic-printer'           => {
      'resourcedef'             => {
        'use'                   => 'generic-host',
        'check_period'          => '24x7',
        'check_interval'        => '5',
        'retry_interval'        => '1',
        'max_check_attempts'    => '10',
        'check_command'         => 'check-host-alive',
        'notification_period'   => 'workhours',
        'notification_interval' => '30',
        'notification_options'  => 'd,r',
        'contact_groups'        => 'admins',
        'statusmap_image'       => 'printer.png',
        'register'              => '0',
      },
    },
    'generic-switch'            => {
      'resourcedef'             => {
        'use'                   => 'generic-host',
        'check_period'          => '24x7',
        'check_interval'        => '5',
        'retry_interval'        => '1',
        'max_check_attempts'    => '10',
        'check_command'         => 'check-host-alive',
        'notification_period'   => '24x7',
        'notification_interval' => '30',
        'notification_options'  => 'd,r',
        'contact_groups'        => 'admins',
        'statusmap_image'       => 'switch.png',
        'register'              => '0',
      },
    },
    'generic-router'      => {
      'resourcedef'       => {
        'use'             => 'generic-switch',
        'statusmap_image' => 'router.png',
        'register'        => '0',
      },
    },
  }

  $templateservice = {
    'generic-service'                  => {
      'resourcedef'                    => {
        'active_checks_enabled'        => '1',
        'passive_checks_enabled'       => '1',
        'parallelize_check'            => '1',
        'obsess_over_service'          => '1',
        'check_freshness'              => '0',
        'notifications_enabled'        => '1',
        'event_handler_enabled'        => '1',
        'flap_detection_enabled'       => '1',
        'failure_prediction_enabled'   => '1',
        'process_perf_data'            => '1',
        'retain_status_information'    => '1',
        'retain_nonstatus_information' => '1',
        'is_volatile'                  => '0',
        'check_period'                 => '24x7',
        'max_check_attempts'           => '3',
        'normal_check_interval'        => '10',
        'retry_check_interval'         => '2',
        'contact_groups'               => 'admins',
        'notification_options'         => 'w,u,c,r',
        'notification_interval'        => '60',
        'notification_period'          => '24x7',
        'register'                     => '0',
      },
    },
    'local-service'             => {
      'resourcedef'             => {
        'use'                   => 'generic-service',
        'max_check_attempts'    => '4',
        'normal_check_interval' => '5',
        'retry_check_interval'  => '1',
        'register'              => '0',
      },
    },
  }

  $templatetimeperiod = {
    '24x7'          => {
      'resourcedef' => {
        'alias'     => '24 Hours A Day, 7 Days A Week',
        'sunday'    => '00:00-24:00',
        'monday'    => '00:00-24:00',
        'tuesday'   => '00:00-24:00',
        'wednesday' => '00:00-24:00',
        'thursday'  => '00:00-24:00',
        'friday'    => '00:00-24:00',
        'saturday'  => '00:00-24:00',
      }
    },
    'workhours'     => {
      'resourcedef' => {
        'alias'     => 'Normal Work Hours',
        'monday'    => '09:00-17:00',
        'tuesday'   => '09:00-17:00',
        'wednesday' => '09:00-17:00',
        'thursday'  => '09:00-17:00',
        'friday'    => '09:00-17:00',
      },
    },
    'none'          => {
      'resourcedef' => {
        'alias'       => 'No Time Is A Good Time',
      },
    },
  }

  # these are taken from the EPEL installation of nagios
  # plus the addition of notify-{host,service}-by-epager
  # disable 80chars linting for this block as the lines just need to be long :(
  # lint:ignore:80chars
  $defaultcommands = {
    'notify-host-by-email' => {
      'resourcedef'        => {
        'command_line'     => '/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\nHost: $HOSTNAME$\nState: $HOSTSTATE$\nAddress: $HOSTADDRESS$\nInfo: $HOSTOUTPUT$\n\nDate/Time: $LONGDATETIME$\n" | /bin/mail -s "** $NOTIFICATIONTYPE$ Host Alert: $HOSTNAME$ is $HOSTSTATE$ **" $CONTACTEMAIL$',
      },
    },
    'notify-service-by-email' => {
      'resourcedef'           => {
        'command_line'        => '/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\n\nService: $SERVICEDESC$\nHost: $HOSTALIAS$\nAddress: $HOSTADDRESS$\nState: $SERVICESTATE$\n\nDate/Time: $LONGDATETIME$\n\nAdditional Info:\n\n$SERVICEOUTPUT$\n" | /bin/mail -s "** $NOTIFICATIONTYPE$ Service Alert: $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$ **" $CONTACTEMAIL$',
      },
    },
    'notify-host-by-epager' => {
      'resourcedef'         => {
        'command_line'      => '/usr/bin/printf "%b" "Info: $HOSTOUTPUT$\nTime: $SHORTDATETIME$" | /bin/mail -s "$NOTIFICATIONTYPE$: $HOSTNAME$ $HOSTSTATE$" $CONTACTPAGER$'
      },
    },
    'notify-service-by-epager' => {
      'resourcedef'            => {
        'command_line'         => '/usr/bin/printf "%b" "Info: $SERVICEOUTPUT$\nDate: $SHORTDATETIME$" | /bin/mail -s "$NOTIFICATIONTYPE$: $HOSTNAME$/$SERVICEDESC$ $SERVICESTATE$" $CONTACTPAGER$'
      },
    },
    'check-host-alive' => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_ping -H $HOSTADDRESS$ -w 3000.0,80% -c 5000.0,100% -p 5',
      },
    },
    'check_local_disk' => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$',
      },
    },
    'check_local_load' => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_load -w $ARG1$ -c $ARG2$',
      },
    },
    'check_local_procs' => {
      'resourcedef'     => {
        'command_line'  => '$USER1$/check_procs -w $ARG1$ -c $ARG2$ -s $ARG3$',
      },
    },
    'check_local_users' => {
      'resourcedef'     => {
        'command_line'  => '$USER1$/check_users -w $ARG1$ -c $ARG2$',
      },
    },
    'check_local_swap' => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_swap -w $ARG1$ -c $ARG2$',
      },
    },
    'check_local_mrtgtraf' => {
      'resourcedef'        => {
        'command_line'     => '$USER1$/check_mrtgtraf -F $ARG1$ -a $ARG2$ -w $ARG3$ -c $ARG4$ -e $ARG5$',
      },
    },
    'check_ftp'        => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_ftp -H $HOSTADDRESS$ $ARG1$',
      },
    },
    'check_hpjd'       => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_hpjd -H $HOSTADDRESS$ $ARG1$',
      },
    },
    'check_snmp'       => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_snmp -H $HOSTADDRESS$ $ARG1$',
      },
    },
    'check_http'       => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_http -I $HOSTADDRESS$ $ARG1$',
      },
    },
    'check_ssh'        => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_ssh $ARG1$ $HOSTADDRESS$',
      },
    },
    'check_dhcp'       => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_dhcp $ARG1$',
      },
    },
    'check_ping'       => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_ping -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$ -p 5',
      },
    },
    'check_pop'        => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_pop -H $HOSTADDRESS$ $ARG1$',
      },
    },
    'check_imap'       => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_imap -H $HOSTADDRESS$ $ARG1$',
      },
    },
    'check_smtp'       => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_smtp -H $HOSTADDRESS$ $ARG1$',
      },
    },
    'check_tcp'        => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_tcp -H $HOSTADDRESS$ -p $ARG1$ $ARG2$',
      },
    },
    'check_udp'        => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_udp -H $HOSTADDRESS$ -p $ARG1$ $ARG2$',
      },
    },
    'check_nt'         => {
      'resourcedef'    => {
        'command_line' => '$USER1$/check_nt -H $HOSTADDRESS$ -p 12489 -v $ARG1$ $ARG2$',
      },
    },
    'process-host-perfdata' => {
      'resourcedef'         => {
        'command_line'      => '/usr/bin/printf "%b" "$LASTHOSTCHECK$\t$HOSTNAME$\t$HOSTSTATE$\t$HOSTATTEMPT$\t$HOSTSTATETYPE$\t$HOSTEXECUTIONTIME$\t$HOSTOUTPUT$\t$HOSTPERFDATA$\n" >> /var/log/nagios/host-perfdata.out'
      },
    },
    'process-service-perfdata' => {
      'resourcedef'            => {
        'command_line'         => '/usr/bin/printf "%b" "$LASTSERVICECHECK$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICESTATE$\t$SERVICEATTEMPT$\t$SERVICESTATETYPE$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$\n" >> /var/log/nagios/service-perfdata.out',
      },
    },
  }
  # lint:endignore

  $defaultcontacts = {
    'nagiosadmin'   => {
      'resourcedef' => {
        'use'       => 'generic-contact',
        'alias'     => 'Nagios Admin',
        'email'     => 'nagios@localhost',
      },
    },
  }

  $defaultcontactgroups = {
    'admins'        => {
      'resourcedef' => {
        'alias'     => 'Nagios Administrators',
        'members'   => 'nagiosadmin',
      },
    },
  }

  $defaulthostgroups = {
    'Other'         => {
      'resourcedef' => {
        'alias'     => 'Default Host Group',
      },
    },
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
  $conffile    = "${rootdir}/nagios.cfg"

  # default list of plugins to install
  # only define nagios-plugins-all by default as that will pull in all
  # nagios plugins. If the server should only have select plugins
  # installed they will need to be individually specified.
  $plugins = [
      'nagios-plugins-all'
    ]
}
