require 'spec_helper'

describe 'nagios::client', :type => :class do
  let(:conf_path) { '/etc/nagios/conf.d' }

  on_supported_os.each do |os,facts|
    let(:facts) do
      facts
    end

    context "on #{os} with defaults for all parameters" do
      it { should contain_class('nagios::client') }
      it { should contain_nagios__resource(facts['fqdn']).with(
        'resource_type'                 => 'host',
        'nagiostag'            => '',
        'defaultresourcedef'   => {
          'address'            => facts['ipaddress'],
          'alias'              => 'test',
          'check_command'      => 'check-host-alive',
          'check_interval'     => '5',
          'ensure'             => 'present',
          'host_name'          => facts['fqdn'],
          'hostgroups'         => ['Other'],
          'max_check_attempts' => '3',
          'retry_interval'     => '1',
          'use'                => 'generic-host',
        },
      ) }
      it { should contain_nagios__resource__host(facts['fqdn']) }
      it { expect(exported_resources).to contain_nagios_host(facts['fqdn']) }
      it { expect(exported_resources).to contain_file("#{conf_path}/host_#{facts['fqdn']}_#{facts['fqdn']}.cfg") }
    end

    context "on #{os} with various resources defined" do
      let(:params) {
        {
          'baseservices'                    => {
            "testservice-#{facts['fqdn']}"  => {
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
            'host_name'                     => facts['fqdn'],
          },
          'hostdependencies'                => {
            "dep-#{facts['fqdn']}"          => {
              'resourcedef'                 => {
                'dependent_host_name'       => 'dependent_host',
              },
            },
          },
          'hostextinfo'                     => {
            "ext-#{facts['fqdn']}"          => {
              'resourcedef'                 => {
                'notes'                     => 'test note',
              },
            },
          },
          'hostservices'                    => {
            "testservice2-#{facts['fqdn']}" => {
              'resourcedef'                 => {
                'service_description'       => 'test service2',
                'check_command'             => 'testcommand2',
              },
            },
          },
          'hostservicedependencies'         => {
            "servicedep1-#{facts['fqdn']}"  => {
              'resourcedef'                 => {
                'dependent_host_name'       => 'dependent_host',
              },
            },
          },
          'hostserviceescalation'           => {
            "escalation1-#{facts['fqdn']}"  => {
              'resourcedef'                 => {
                'contacts'                  => 'contact',
              },
            },
          },
          'hostserviceextinfo'              => {
            "extinfo1-#{facts['fqdn']}"     => {
              'resourcedef'                 => {
                'service_description'       => "testservice2-#{facts['fqdn']}",
              },
            },
          },
          'plugins'                         => [
            'extra-plugin',
          ],
        }
      }

      it { should contain_nagios__resource("testservice-#{facts['fqdn']}").with(
        'resource_type'          => 'service',
        'nagiostag'             => '',
        'defaultresourcedef'    => {
          'check_interval'      => '5',
          'ensure'              => 'present',
          'host_name'           => facts['fqdn'],
          'max_check_attempts'  => '3',
          'retry_interval'      => '1',
          'use'                 => 'generic-service',
        },
        'resourcedef'           => {
          'service_description' => 'test service',
          'check_command'       => 'testcommand',
        },
      ) }
      it { should contain_nagios__resource__service("testservice-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_nagios_service("testservice-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_file("#{conf_path}/service_#{facts['fqdn']}_testservice-#{facts['fqdn']}.cfg") }

      it { should contain_nagios__resource("dep-#{facts['fqdn']}").with(
        'resource_type'          => 'hostdependency',
        'defaultresourcedef'    => {
          'host_name'           => 'hostdeptest'
        },
        'resourcedef'           => {
          'dependent_host_name' => 'dependent_host',
        },
      ) }
      it { should contain_nagios__resource__hostdependency("dep-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_nagios_hostdependency("dep-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_file("#{conf_path}/hostdependency_#{facts['fqdn']}_dep-#{facts['fqdn']}.cfg") }

      it { should contain_nagios__resource("ext-#{facts['fqdn']}").with(
        'resource_type'       => 'hostextinfo',
        'defaultresourcedef'  => {
          'host_name'         => facts['fqdn'],
        },
        'resourcedef'         => {
          'notes'             => 'test note',
        },
      ) }
      it { should contain_nagios__resource__hostextinfo("ext-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_nagios_hostextinfo("ext-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_file("#{conf_path}/hostextinfo_#{facts['fqdn']}_ext-#{facts['fqdn']}.cfg") }

      it { should contain_nagios__resource("testservice2-#{facts['fqdn']}").with(
        'resource_type'         => 'service',
        'defaultresourcedef'    => {
          'check_interval'      => '5',
          'ensure'              => 'present',
          'host_name'           => facts['fqdn'],
          'max_check_attempts'  => '3',
          'retry_interval'      => '1',
          'use'                 => 'generic-service',
        },
        'resourcedef'           => {
          'service_description' => 'test service2',
          'check_command'       => 'testcommand2',
        },
      ) }
      it { should contain_nagios__resource__service("testservice2-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_nagios_service("testservice2-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_file("#{conf_path}/service_#{facts['fqdn']}_testservice2-#{facts['fqdn']}.cfg") }

      it { should contain_nagios__resource("servicedep1-#{facts['fqdn']}").with(
        'resource_type'         => 'servicedependency',
        'defaultresourcedef'    => {
          'host_name'           => facts['fqdn'],
        },
        'resourcedef'           => {
          'dependent_host_name' => 'dependent_host',
        },
      ) }
      it { should contain_nagios__resource__servicedependency("servicedep1-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_nagios_servicedependency("servicedep1-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_file("#{conf_path}/servicedependency_#{facts['fqdn']}_servicedep1-#{facts['fqdn']}.cfg") }

      it { should contain_nagios__resource("escalation1-#{facts['fqdn']}").with(
        'resource_type'      => 'serviceescalation',
        'defaultresourcedef' => {
          'host_name'        => facts['fqdn'],
        },
        'resourcedef'        => {
          'contacts'         => 'contact',
        },
      ) }
      it { should contain_nagios__resource__serviceescalation("escalation1-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_nagios_serviceescalation("escalation1-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_file("#{conf_path}/serviceescalation_#{facts['fqdn']}_escalation1-#{facts['fqdn']}.cfg") }

      it { should contain_nagios__resource("extinfo1-#{facts['fqdn']}").with(
        'resource_type'         => 'serviceextinfo',
        'defaultresourcedef'    => {
          'host_name'           => facts['fqdn'],
        },
        'resourcedef'           => {
          'service_description' => "testservice2-#{facts['fqdn']}",
        },
      ) }
      it { should contain_nagios__resource__serviceextinfo("extinfo1-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_nagios_serviceextinfo("extinfo1-#{facts['fqdn']}") }
      it { expect(exported_resources).to contain_file("#{conf_path}/serviceextinfo_#{facts['fqdn']}_extinfo1-#{facts['fqdn']}.cfg") }

      it 'should have a nagios tag when one is defined' do
        params.merge!({'nagiostag' => 'test'})
        should contain_nagios__resource(facts['fqdn']).with(
          'nagiostag' => 'test',
        )
      end

      it { should contain_package('extra-plugin') }
    end
  end
end

# vim: ts=2 sw=2 sts=2 et :
