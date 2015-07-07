require 'spec_helper'
describe 'nagios::client', :type => :class do
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
    it { should contain_class('nagios::client') }
    it { should contain_nagios__resource('test.example.com').with(
      'type'                 => 'host',
      'nagiostag'            => '',
      'defaultresourcedef'   => {
        'address'            => '192.168.0.1',
        'alias'              => 'test',
        'check_command'      => 'check-host-alive',
        'check_interval'     => '5',
        'ensure'             => 'present',
        'host_name'          => 'test.example.com',
        'hostgroups'         => ['CentOS'],
        'max_check_attempts' => '3',
        'retry_interval'     => '1',
        'use'                => 'generic-host',
      },
    ) }
  end

  context 'with various resources defined' do
    let(:params) {
      {
        'baseservices'                    => {
          'testservice-test.example.com'  => {
            'resourcedef'                 => {
              'service_description'       => 'test service',
              'check_command'             => 'testcommand',
            },
          }
        },
        'defaulthostdependencies'         => {
          'host_name'                     => 'hostdeptest',
        },
        'defaultservicedependencies'      => {
          'host_name'                     => 'test.example.com',
        },
        'hostdependencies'                => {
          'dep-test.example.com'          => {
            'resourcedef'                 => {
              'dependent_host_name'       => 'dependent_host',
            },
          },
        },
        'hostextinfo'                     => {
          'ext-test.example.com'          => {
            'resourcedef'                 => {
              'notes'                     => 'test note',
            },
          },
        },
        'hostservices'                    => {
          'testservice2-test.example.com' => {
            'resourcedef'                 => {
              'service_description'       => 'test service2',
              'check_command'             => 'testcommand2',
            },
          },
        },
        'hostservicedependencies'         => {
          'servicedep1-test.example.com'  => {
            'resourcedef'                 => {
              'dependent_host_name'       => 'dependent_host',
            },
          },
        },
        'hostserviceescalation'           => {
          'escalation1-test.example.com'  => {
            'resourcedef'                 => {
              'contacts'                  => 'contact',
            },
          },
        },
        'hostserviceextinfo'              => {
          'extinfo1-test.example.com'     => {
            'resourcedef'                 => {
              'service_description'       => 'testservice2-text.example.com',
            },
          },
        },
        'plugins'                         => [
          'extra-plugin',
        ],
      }
    }

    it { should contain_nagios__resource('testservice-test.example.com').with(
      'type'                  => 'service',
      'nagiostag'             => '',
      'defaultresourcedef'    => {
        'check_interval'      => '5',
        'ensure'              => 'present',
        'host_name'           => 'test.example.com',
        'max_check_attempts'  => '3',
        'retry_interval'      => '1',
        'use'                 => 'generic-service',
      },
      'resourcedef'           => {
        'service_description' => 'test service',
        'check_command'       => 'testcommand',
      },
    ) }

    it { should contain_nagios__resource('dep-test.example.com').with(
      'type'                  => 'hostdependency',
      'defaultresourcedef'    => {
        'host_name'           => 'hostdeptest'
      },
      'resourcedef'           => {
        'dependent_host_name' => 'dependent_host',
      },
    ) }

    it { should contain_nagios__resource('ext-test.example.com').with(
      'type'                => 'hostextinfo',
      'defaultresourcedef'  => {
        'host_name'         => 'test.example.com',
      },
      'resourcedef'         => {
        'notes'             => 'test note',
      },
    ) }

    it { should contain_nagios__resource('testservice2-test.example.com').with(
      'type'                  => 'service',
      'defaultresourcedef'    => {
        'check_interval'      => '5',
        'ensure'              => 'present',
        'host_name'           => 'test.example.com',
        'max_check_attempts'  => '3',
        'retry_interval'      => '1',
        'use'                 => 'generic-service',
      },
      'resourcedef'           => {
        'service_description' => 'test service2',
        'check_command'       => 'testcommand2',
      },
    ) }

    it { should contain_nagios__resource('servicedep1-test.example.com').with(
      'type'                  => 'servicedependency',
      'defaultresourcedef'    => {
        'host_name'           => 'test.example.com',
      },
      'resourcedef'           => {
        'dependent_host_name' => 'dependent_host',
      },
    ) }

    it { should contain_nagios__resource('escalation1-test.example.com').with(
      'type'               => 'serviceescalation',
      'defaultresourcedef' => {
        'host_name'        => 'test.example.com',
      },
      'resourcedef'        => {
        'contacts'         => 'contact',
      },
    ) }

    it { should contain_nagios__resource('extinfo1-test.example.com').with(
      'type'                  => 'serviceextinfo',
      'defaultresourcedef'    => {
        'host_name'           => 'test.example.com',
      },
      'resourcedef'           => {
        'service_description' => 'testservice2-text.example.com',
      },
    ) }

    it 'should have a nagios tag when one is defined' do
      params.merge!({'nagiostag' => 'test'})
      should contain_nagios__resource('test.example.com').with(
        'nagiostag' => 'test',
      )
    end

    it { should contain_package('extra-plugin') }
  end
end

# vim: ts=2 sw=2 sts=2 et :
