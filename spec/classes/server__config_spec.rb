require 'spec_helper'
describe 'nagios::server::config' do
  let(:facts) {
    {
      :fqdn            => 'test.example.com',
      :hostname        => 'test',
      :ipaddress       => '192.168.0.1',
      :operatingsystem => 'CentOS',
      :osfamily        => 'RedHat'
    }
  }

  # we do not have default values so the class should fail compile
  context 'with defaults for all parameters' do
    let (:params) {{}}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass /)
    end
  end

  context 'with basic init defaults' do
    let(:params) {
      {
        'conffile'                  => '/etc/nagios/nagios.cfg',
        'defaultcommands'           => {},
        'defaultcontacts'           => {},
        'defaultcontactgroups'      => {},
        'defaulthostgroups'         => {},
        'localcommands'             => {},
        'localcommanddefaults'      => {},
        'localcontacts'             => {},
        'localcontactdefaults'      => {},
        'localcontactgroups'        => {},
        'localcontactgroupdefaults' => {},
        'localhostgroups'           => {},
        'localhostgroupdefaults'    => {},
        'nagios_cfg'                => {
          # base defaults (assuming RedHat)
          'accept_passive_host_checks'                  => 1,
          'accept_passive_service_checks'               => 1,
          'additional_freshness_latency'                => 15,
          'admin_email'                                 => 'root@test.example.com',
          'admin_pager'                                 => 'pagenagios@localhost',
          'auto_reschedule_checks'                      => 0,
          'auto_rescheduling_interval'                  => 30,
          'auto_rescheduling_window'                    => 180,
          'bare_update_check'                           => 0,
          'cached_host_check_horizon'                   => 15,
          'cached_service_check_horizon'                => 15,
          'cfg_dir'                                     => [ '/etc/nagios/conf.d' ],
          'check_external_commands'                     => 1,
          'check_for_orphaned_hosts'                    => 1,
          'check_for_orphaned_services'                 => 1,
          'check_for_updates'                           => 1,
          'check_result_path'                           => '/var/lib/nagios/spool/checkresults',
          'check_result_reaper_frequency'               => 10,
          'check_service_freshness'                     => 1,
          'command_check_interval'                      => -1,
          'deamon_dumps_core'                           => 0,
          'debug_file'                                  => '/var/log/nagios/nagios.debug',
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
          'log_archive_path'                            => '/var/log/nagios/archives',
          'log_file'                                    => '/var/log/nagios/nagios.log',
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
          'cache_file'                                  => '/var/cache/nagios/objects.cache',
          'passive_host_checks_are_soft'                => 0,
          'perfdata_timeout'                            => 5,
          'precached_object_file'                       => '/var/cache/nagios/objects/precache',
          'private_resource_file'                       => '/etc/nagios/private/resource.cfg',
          'process_performance_data'                    => 0,
          'retain_state_information'                    => 1,
          'retained_contact_host_attribute_mask'        => 0,
          'retained_contact_service_attribute_mask'     => 0,
          'retained_host_attribute_mask'                => 0,
          'retained_process_host_attribute_mask'        => 0,
          'retained_process_service_attribute_mask'     => 0,
          'retention_update_interval'                   => 60,
          'service_check_timeout'                       => 60,
          'service_check_timeout_state'                 => 'c',
          'service_freshness_check_interval'            => 60,
          'service_inter_check_delay_method'            => 's',
          'service_interleave_factor'                   => 's',
          'sleep_time'                                  => 0.25,
          'soft_state_dependencies'                     => 0,
          'state_retention_file'                        => '/var/lib/nagios/retention.dat',
          'status_file'                                 => '/var/cache/nagios/status.dat',
          'status_update_interval'                      => 10,
          'temp_file'                                   => '/var/cache/nagios/nagios.tmp',
          'temp_path'                                   => '/tmp',
          'translate_passive_host_checks'               => 0,
          'use_aggressive_host_checking'                => 0,
          'use_embedded_perl_implicitly'                => 1,
          'use_large_installation_tweaks'               => 0,
          'use_regexp_matching'                         => 0,
          'use_retained_scheduling_info'                => 1,
          'use_syslog'                                  => 1,
          'use_true_regexp_matching'                    => 0,
          # os specific defaults (assuming RedHat)
          'check_host_freshness'                        => 0,
          'command_file'                                => '/var/spool/nagios/cmd/nagios.cmd',
          'date_format'                                 => 'us',
          'debug_verbosity'                             => 1,
          'host_check_timeout'                          => 30,
          'lock_file'                                   => '/var/run/nagios.pid',
          'log_event_handlers'                          => 1,
          'log_external_commands'                       => 1,
          'log_host_retries'                            => 1,
          'log_notifications'                           => 1,
          'log_passive_checks'                          => 1,
          'log_service_checks'                          => 1,
          'obsess_over_hosts'                           => 0,
          'obsess_over_services'                        => 0,
          'ocsp_timeout'                                => 5,
          'p1_file'                                     => '/usr/sbin/p1.pl',
          'use_retained_program_state'                  => 1,
        },
        'nagiostag'                 => '',
        'templatecontact'           => {},
        'templatehost'              => {},
        'templateservice'           => {},
        'templatetimeperiod'        => {},
      }
    }

    it { should contain_class('nagios::server::config') }
    it { should contain_anchor('nagios::server::config::begin') }
    it { should contain_class('nagios::server::config::export') }
    it { should contain_class('nagios::server::config::import') }
    it { should contain_anchor('nagios::server::config::end') }

    it { should contain_file('nagios resourcedir').with(
      'ensure'  => 'directory',
      'path'    => '/etc/nagios/conf.d',
      'purge'   => true,
      'recurse' => true,
    ).that_comes_before('Class[nagios::server::config::import]') }

    it { should contain_file('/etc/nagios/nagios.cfg').with(
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0664',
      'content' => "##########
##
## STOP THIS FILE IS MANAGED BY PUPPET
##
##########

accept_passive_host_checks=1
accept_passive_service_checks=1
additional_freshness_latency=15
admin_email=root@test.example.com
admin_pager=pagenagios@localhost
auto_reschedule_checks=0
auto_rescheduling_interval=30
auto_rescheduling_window=180
bare_update_check=0
cache_file=/var/cache/nagios/objects.cache
cached_host_check_horizon=15
cached_service_check_horizon=15
cfg_dir=/etc/nagios/conf.d
check_external_commands=1
check_for_orphaned_hosts=1
check_for_orphaned_services=1
check_for_updates=1
check_host_freshness=0
check_result_path=/var/lib/nagios/spool/checkresults
check_result_reaper_frequency=10
check_service_freshness=1
command_check_interval=-1
command_file=/var/spool/nagios/cmd/nagios.cmd
date_format=us
deamon_dumps_core=0
debug_file=/var/log/nagios/nagios.debug
debug_level=0
debug_verbosity=1
enable_embedded_perl=1
enable_environment_macros=1
enable_event_handlers=1
enable_flap_detection=1
enable_notifications=1
enable_predictive_host_dependency_checks=1
enable_predictive_service_dependency_checks=1
event_broker_options=-1
event_handler_timeout=30
execute_host_checks=1
execute_service_checks=1
external_command_buffer_slots=4096
high_host_flap_threshold=20.0
high_service_flap_threshold=20.0
host_check_timeout=30
host_freshness_check_interval=60
host_inter_check_delay_method=s
illegal_macro_output_chars=`~$&|'\"<>
illegal_object_name_chars=`~!$%^&*|'\"<>?,()=
interval_length=60
lock_file=/var/run/nagios.pid
log_archive_path=/var/log/nagios/archives
log_event_handlers=1
log_external_commands=1
log_file=/var/log/nagios/nagios.log
log_host_retries=1
log_initial_states=0
log_notifications=1
log_passive_checks=1
log_rotation_method=d
log_service_checks=1
low_host_flap_threshold=5.0
low_service_flap_threshold=5.0
max_check_result_file_age=3600
max_check_result_reaper_time=30
max_concurrent_checks=0
max_debug_file_size=1000000
max_host_check_spread=30
max_service_check_spread=30
nagios_group=nagios
nagios_user=nagios
notification_timeout=30
obsess_over_hosts=0
obsess_over_services=0
ocsp_timeout=5
p1_file=/usr/sbin/p1.pl
passive_host_checks_are_soft=0
perfdata_timeout=5
precached_object_file=/var/cache/nagios/objects/precache
private_resource_file=/etc/nagios/private/resource.cfg
process_performance_data=0
retain_state_information=1
retained_contact_host_attribute_mask=0
retained_contact_service_attribute_mask=0
retained_host_attribute_mask=0
retained_process_host_attribute_mask=0
retained_process_service_attribute_mask=0
retention_update_interval=60
service_check_timeout=60
service_check_timeout_state=c
service_freshness_check_interval=60
service_inter_check_delay_method=s
service_interleave_factor=s
sleep_time=0.25
soft_state_dependencies=0
state_retention_file=/var/lib/nagios/retention.dat
status_file=/var/cache/nagios/status.dat
status_update_interval=10
temp_file=/var/cache/nagios/nagios.tmp
temp_path=/tmp
translate_passive_host_checks=0
use_aggressive_host_checking=0
use_embedded_perl_implicitly=1
use_large_installation_tweaks=0
use_regexp_matching=0
use_retained_program_state=1
use_retained_scheduling_info=1
use_syslog=1
use_true_regexp_matching=0
",
    ) }
  end
end

# vim: ts=2 sw=2 sts=2 et :
