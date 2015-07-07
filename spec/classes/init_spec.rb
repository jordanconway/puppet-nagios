require 'spec_helper'
describe 'nagios' do
  let(:facts) {
    {
      :fqdn            => 'test.example.com',
      :hostname        => 'test',
      :ipaddress       => '192.168.0.1',
      :operatingsystem => 'CentOS',
      :osfamily        => 'RedHat'
    }
  }

  context 'with defaults for all parameters' do
    it { should contain_class('nagios') }
    it { should contain_package('nagios') }
    it { should contain_package('nagios-plugins-all') }

    # only check some of the base params templates
    it { should contain_nagios__resource('generic-contact').with(
      'type'                            => 'contact',
      'nagiostag'                       => 'test.example.com',
      'defaultresourcedef'              => {},
      'resourcedef'                     => {
        'host_notification_commands'    => 'notify-host-by-email',
        'host_notification_options'     => 'd,u,r,f,s',
        'host_notification_period'      => '24x7',
        'register'                      => '0',
        'service_notification_commands' => 'notify-service-by-email',
        'service_notification_options'  => 'w,u,c,r,f,s',
        'service_notification_period'   => '24x7',
      },
    ) }

    it { should contain_nagios__resource('generic-host').with(
      'type' => 'host',
    ) }

    it { should contain_nagios__resource('linux-server') }
    it { should contain_nagios__resource('windows-server') }
    it { should contain_nagios__resource('generic-printer') }
    it { should contain_nagios__resource('generic-switch') }
    it { should contain_nagios__resource('generic-router') }

    it { should contain_nagios__resource('generic-service').with(
      'type' => 'service',
    ) }
    it { should contain_nagios__resource('local-service') }

    it { should contain_nagios__resource('24x7').with(
      'type' => 'timeperiod',
    ) }
    it { should contain_nagios__resource('workhours') }
    it { should contain_nagios__resource('none') }

    it { should contain_nagios__resource('notify-host-by-email').with(
      'type' => 'command',
    ) }
    it { should contain_nagios__resource('notify-service-by-email') }
    it { should contain_nagios__resource('notify-host-by-epager') }
    it { should contain_nagios__resource('notify-service-by-epager') }
    it { should contain_nagios__resource('check-host-alive') }
    it { should contain_nagios__resource('check_local_disk') }
    it { should contain_nagios__resource('check_local_load') }
    it { should contain_nagios__resource('check_local_procs') }
    it { should contain_nagios__resource('check_local_users') }
    it { should contain_nagios__resource('check_local_swap') }
    it { should contain_nagios__resource('check_local_mrtgtraf') }
    it { should contain_nagios__resource('check_ftp') }
    it { should contain_nagios__resource('check_hpjd') }
    it { should contain_nagios__resource('check_snmp') }
    it { should contain_nagios__resource('check_http') }
    it { should contain_nagios__resource('check_ssh') }
    it { should contain_nagios__resource('check_dhcp') }
    it { should contain_nagios__resource('check_ping') }
    it { should contain_nagios__resource('check_pop') }
    it { should contain_nagios__resource('check_imap') }
    it { should contain_nagios__resource('check_smtp') }
    it { should contain_nagios__resource('check_tcp') }
    it { should contain_nagios__resource('check_udp') }
    it { should contain_nagios__resource('check_nt') }
    it { should contain_nagios__resource('process-host-perfdata') }
    it { should contain_nagios__resource('process-service-perfdata') }

    it { should contain_nagios__resource('nagiosadmin').with(
      'type' => 'contact',
    ) }

    it { should contain_nagios__resource('admins').with(
      'type' => 'contactgroup',
    ) }
  end

  context 'with custom variables' do
    let(:params) {
      {
        'localcommands'      => {
          'test-command'     => {
            'resourcedef'    => {
              'command_line' => 'local test-command',
            },
          },
        },
        'localcommanddefaults' => {
          'use'                => 'default-command',
        },
        'localcontacts'      => {
          'userfoo'          => {
            'resourcedef'    => { },
          },
        },
        'localcontactdefaults' => {
          'use'                => 'default-contact',
        },
        'localcontactgroups' => {
          'groupfoo'         => {
            'resourcedef'    => { },
          },
        },
        'localcontactgroupdefaults' => {
          'use'                     => 'default-contactgroup',
        },
      }
    }

    it { should contain_nagios__resource('test-command').with(
      'type'               => 'command',
      'defaultresourcedef' => {
        'use'              => 'default-command',
      },
    ) }

    it { should contain_nagios__resource('userfoo').with(
      'type'               => 'contact',
      'defaultresourcedef' => {
        'use'              => 'default-contact',
      },
    ) }

    it { should contain_nagios__resource('groupfoo').with(
      'type'               => 'contactgroup',
      'defaultresourcedef' => {
        'use'              => 'default-contactgroup',
      },
    ) }
  end
end

# vim: ts=2 sw=2 sts=2 et :
