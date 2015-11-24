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
    default  => 'nagios',
  }

  $rootdir     = "/etc/${basename}"
  # cfg_dir also uses $resourcedir
  $resourcedir = "${rootdir}/conf.d"
  $conffile    = "${rootdir}/nagios.cfg"
  $cgiconffile = "${rootdir}/cgi.cfg"

  case $::osfamily {
    'RedHat': {
      $os_default_nagios_cfg = {
        'check_host_freshness'       => 0,
        # lint:ignore:80chars
        'check_result_path'          => "/var/log/${basename}/spool/checkresults",
        # lint:endignore
        'command_file'               => "/var/spool/${basename}/cmd/nagios.cmd",
        'date_format'                => 'us',
        'debug_verbosity'            => 1,
        'host_check_timeout'         => 30,
        'lock_file'                  => "/var/run/${basename}.pid",
        'log_event_handlers'         => 1,
        'log_external_commands'      => 1,
        'log_host_retries'           => 1,
        'log_notifications'          => 1,
        'log_passive_checks'         => 1,
        'log_service_retries'        => 1,
        'obsess_over_hosts'          => 0,
        'obsess_over_services'       => 0,
        'ocsp_timeout'               => 5,
        'p1_file'                    => '/usr/sbin/p1.pl',
        'use_retained_program_state' => 1,
        'object_cache_file'          => "/var/log/${basename}/objects.cache",
        'precached_object_file'      => "/var/log/${basename}/objects.precache",
      }
      $os_default_cgi_cfg = {
        'physical_html_path' => '/usr/share/nagios/html',
        'show_context_help'  => 0,
      }
    }
    default: {
      $os_default_nagios_cfg = {
        'check_host_freshness'       => 1,
        # lint:ignore:80chars
        'check_result_path'          => "/var/lib/${basename}/spool/checkresults",
        # lint:endignore
        'command_file'               => "/var/run/${basename}/rw/nagios.cmd",
        'date_format'                => 'iso8601',
        'debug_verbosity'            => 0,
        'host_check_timeout'         => 60,
        'lock_file'                  => "/var/run/${basename}/${basename}.pid",
        'log_event_handlers'         => 0,
        'log_external_commands'      => 0,
        'log_host_retries'           => 0,
        'log_notifications'          => 0,
        'log_passive_checks'         => 0,
        'log_service_retries'        => 0,
        'obsess_over_hosts'          => 1,
        'obsess_over_services'       => 1,
        'ocsp_timeout'               => 10,
        'p1_file'                    => "/usr/lib/${basename}/p1.pl",
        'use_retained_program_state' => 0,
      }
      $os_default_cgi_cfg = {
        # lint:ignore:80chars
        'nagios_check_command' => '/usr/lib/nagios/plugins/check_nagios /var/cache/nagios3/status.dat 5 \'/usr/sbin/nagios3\'',
        # lint:endignore
        'physical_html_path'   => '/usr/share/nagios3/htdocs',
        'show_context_help'    => 1,
      }
    }
  }

  $base_default_nagios_cfg = {
    'accept_passive_host_checks'                  => 1,
    'accept_passive_service_checks'               => 1,
    'additional_freshness_latency'                => 15,
    'admin_email'                                 => "root@${::fqdn}",
    'admin_pager'                                 => 'pagenagios@localhost',
    'auto_reschedule_checks'                      => 0,
    'auto_rescheduling_interval'                  => 30,
    'auto_rescheduling_window'                    => 180,
    'bare_update_check'                           => 0,
    'cached_host_check_horizon'                   => 15,
    'cached_service_check_horizon'                => 15,
    'cfg_dir'                                     => [ $resourcedir ],
    'check_external_commands'                     => 1,
    'check_for_orphaned_hosts'                    => 1,
    'check_for_orphaned_services'                 => 1,
    'check_for_updates'                           => 1,
    'check_result_reaper_frequency'               => 10,
    'check_service_freshness'                     => 1,
    'command_check_interval'                      => -1,
    'daemon_dumps_core'                           => 0,
    # lint:ignore:80chars
    'debug_file'                                  => "/var/log/${basename}/nagios.debug",
    # lint:endignore
    'debug_level'                                 => 0,
    'enable_embedded_perl'                        => 1,
    'enable_environment_macros'                   => 1,
    'enable_event_handlers'                       => 1,
    'enable_flap_detection'                       => 1,
    'enable_notifications'                        => 1,
    'enable_predictive_host_dependency_checks'    => 1,
    'enable_predictive_service_dependency_checks' => 1,
    'event_broker_options'                        => -1,
    'event_handler_timeout'                       => 30,
    'execute_host_checks'                         => 1,
    'execute_service_checks'                      => 1,
    'external_command_buffer_slots'               => 4096,
    'high_host_flap_threshold'                    => 20.0,
    'high_service_flap_threshold'                 => 20.0,
    'host_freshness_check_interval'               => 60,
    'host_inter_check_delay_method'               => 's',
    'illegal_object_name_chars'                   => "`~!$%^&*|'\"<>?,()=",
    'illegal_macro_output_chars'                  => "`~$&|'\"<>",
    'interval_length'                             => 60,
    # lint:ignore:80chars
    'log_archive_path'                            => "/var/log/${basename}/archives",
    'log_file'                                    => "/var/log/${basename}/nagios.log",
    # lint:endignore
    'log_initial_states'                          => 0,
    'log_rotation_method'                         => 'd',
    'low_host_flap_threshold'                     => 5.0,
    'low_service_flap_threshold'                  => 5.0,
    'max_check_result_file_age'                   => 3600,
    'max_check_result_reaper_time'                => 30,
    'max_concurrent_checks'                       => 0,
    'max_debug_file_size'                         => 1000000,
    'max_host_check_spread'                       => 30,
    'max_service_check_spread'                    => 30,
    'nagios_group'                                => 'nagios',
    'nagios_user'                                 => 'nagios',
    'notification_timeout'                        => 30,
    # lint:ignore:80chars
    'object_cache_file'                           => "/var/cache/${basename}/objects.cache",
    # lint:endignore
    'passive_host_checks_are_soft'                => 0,
    'perfdata_timeout'                            => 5,
    # lint:ignore:80chars
    'precached_object_file'                       => "/var/cache/${basename}/objects.precache",
    # lint:endignore
    'process_performance_data'                    => 0,
    # lint:ignore:80chars
    'resource_file'                               => "/etc/${basename}/private/resource.cfg",
    # lint:endignore
    'retain_state_information'                    => 1,
    'retained_contact_host_attribute_mask'        => 0,
    'retained_contact_service_attribute_mask'     => 0,
    'retained_host_attribute_mask'                => 0,
    'retained_process_host_attribute_mask'        => 0,
    'retained_process_service_attribute_mask'     => 0,
    'retained_service_attribute_mask'             => 0,
    'retention_update_interval'                   => 60,
    'service_check_timeout'                       => 60,
    'service_check_timeout_state'                 => 'c',
    'service_freshness_check_interval'            => 60,
    'service_inter_check_delay_method'            => 's',
    'service_interleave_factor'                   => 's',
    'sleep_time'                                  => 0.25,
    'soft_state_dependencies'                     => 0,
    # lint:ignore:80chars
    'state_retention_file'                        => "/var/lib/${basename}/retention.dat",
    'status_file'                                 => "/var/cache/${basename}/status.dat",
    # lint:endignore
    'status_update_interval'                      => 10,
    # lint:ignore:80chars
    'temp_file'                                   => "/var/cache/${basename}/nagios.tmp",
    # lint:endignore
    'temp_path'                                   => '/tmp',
    'translate_passive_host_checks'               => 0,
    'use_aggressive_host_checking'                => 0,
    'use_embedded_perl_implicitly'                => 1,
    'use_large_installation_tweaks'               => 0,
    'use_regexp_matching'                         => 0,
    'use_retained_scheduling_info'                => 1,
    'use_syslog'                                  => 1,
    'use_true_regexp_matching'                    => 0,
  }

  $base_default_cgi_cfg = {
    'action_url_target'                        => '_blank',
    'authorized_for_all_hosts'                 => 'nagiosadmin',
    'authorized_for_all_host_commands'         => 'nagiosadmin',
    'authorized_for_all_services'              => 'nagiosadmin',
    'authorized_for_all_service_commands'      => 'nagiosadmin',
    'authorized_for_configuration_information' => 'nagiosadmin',
    'authorized_for_system_commands'           => 'nagiosadmin',
    'authorized_for_system_information'        => 'nagiosadmin',
    'default_statusmap_layout'                 => 5,
    'default_statuswrl_layout'                 => 4,
    'escape_html_tags'                         => 1,
    'lock_author_names'                        => 1,
    'main_config_file'                         => $conffile,
    'notes_url_target'                         => '_blank',
    # lint:ignore:80chars
    'ping_syntax'                              => '/bin/ping -n -U -c 5 $HOSTADDRESS$',
    # lint:endignore
    'refresh_rate'                             => 90,
    'result_limit'                             => 100,
    'url_html_path'                            => "/${basename}",
    'use_authentication'                       => 1,
    'use_pending_states'                       => 1,
    'use_ssl_authentication'                   => 0,
  }

  # lint:ignore:80chars
  $default_nagios_config = merge($base_default_nagios_cfg, $os_default_nagios_cfg)
  # lint:endignore

  $default_cgi_config = merge($base_default_cgi_cfg, $os_default_cgi_cfg)

  $user1 = $::osfamily ? {
    'Debian'   => '/usr/lib/nagios/plugins',
    'RedHat'   => $::architecture ? {
      'x86_64' => '/usr/lib64/nagios/plugins',
      default  => '/usr/lib/nagios/plugins',
    },
  }

  # default resource macros
  # The ordering of this array will determine the the macro numbering
  $resource_macros = [
    $user1
  ]

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

  # default list of plugins to install
  # only define nagios-plugins-all by default as that will pull in all
  # nagios plugins. If the server should only have select plugins
  # installed they will need to be individually specified.
  $plugins = $::osfamily ? {
    'Debian' => ['nagios-plugins'],
    default  => ['nagios-plugins-all'],
  }
}
