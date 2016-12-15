require 'spec_helper'

describe 'nagios::server::config::export' do
  let(:conf_path) { '/etc/nagios/conf.d' }
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    # we do not have default values so the class should fail compile
    context "on #{os} with defaults for all parameters" do
      let (:params) {{}}

      it do
        expect {
          should compile
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context "on #{os} with basic init defaults" do
      let(:params) {
        {
          'defaultcommands' => {
            'defaultcommand'=> {
              'resourcedef' => {},
            },
          },
          'defaultcontacts'  => {
            'defaultcontact' => {
              'resourcedef'  => {},
            },
          },
          'defaultcontactgroups'  => {
            'defaultcontactgroup' => {
              'resourcedef'       => {},
            },
          },
          'defaulthostgroups'  => {
            'defaulthostgroup' => {
              'resourcedef'    => {},
            },
          },
          'localcommands'   => {
            'localcommand'  => {
              'resourcedef' => {},
            },
          },
          'localcommanddefaults' => {
            'use'                => 'defaultcommand',
          },
          'localcontacts'   => {
            'localcontact'  => {
              'resourcedef' => {},
            },
          },
          'localcontactdefaults' => {
            'use'                => 'defaultcontact'
          },
          'localcontactgroups'  => {
            'localcontactgroup' => {
              'resourcedef'     => {},
            },
          },
          'localcontactgroupdefaults' => {
            'use'                     => 'defaultcontactgroup',
          },
          'localhostgroups'  => {
            'localhostgroup' => {
              'resourcedef'  => {},
            },
          },
          'localhostgroupdefaults' => {
            'use'                  => 'defaulthostgroup',
          },
          'nagiostag'         => 'test',
          'templatecontact'   => {
            'templatecontact' => {
              'resourcedef'   => {},
            },
          },
          'templatehost'    =>   {
            'templatehost'  => {
              'resourcedef' => {},
            },
          },
          'templateservice'   => {
            'templateservice' => {
              'resourcedef'   => {},
            },
          },
          'templatetimeperiod'   => {
            'templatetimeperiod' => {
              'resourcedef'      => {},
            },
          },
        }
      }

      it { should contain_class('nagios::server::config::export') }

      it { should contain_nagios__resource('defaultcommand').with(
        'resource_type'      => 'command',
        'nagiostag'          => 'test',
        'defaultresourcedef' => {},
        'resourcedef'        => {},
      ) }
      it { should contain_nagios__resource__command('defaultcommand') }
      it { expect(exported_resources).to contain_nagios_command('defaultcommand') }
      it { expect(exported_resources).to contain_file("#{conf_path}/command_#{facts['fqdn']}_defaultcommand.cfg") }

      it { should contain_nagios__resource('defaultcontact').with(
        'resource_type' => 'contact',
      ) }
      it { should contain_nagios__resource__contact('defaultcontact') }
      it { expect(exported_resources).to contain_nagios_contact('defaultcontact') }
      it { expect(exported_resources).to contain_file("#{conf_path}/contact_#{facts['fqdn']}_defaultcontact.cfg") }

      it { should contain_nagios__resource('defaultcontactgroup').with(
        'resource_type' => 'contactgroup',
      ) }
      it { should contain_nagios__resource__contactgroup('defaultcontactgroup') }
      it { expect(exported_resources).to contain_nagios_contactgroup('defaultcontactgroup') }
      it { expect(exported_resources).to contain_file("#{conf_path}/contactgroup_#{facts['fqdn']}_defaultcontactgroup.cfg") }

      it { should contain_nagios__resource('defaulthostgroup').with(
        'resource_type' => 'hostgroup',
      ) }
      it { should contain_nagios__resource__hostgroup('defaulthostgroup') }
      it { expect(exported_resources).to contain_nagios_hostgroup('defaulthostgroup') }
      it { expect(exported_resources).to contain_file("#{conf_path}/hostgroup_#{facts['fqdn']}_defaulthostgroup.cfg") }

      it { should contain_nagios__resource('localcommand').with(
        'resource_type'      => 'command',
        'defaultresourcedef' => {
          'use'              => 'defaultcommand',
        },
      ) }
      it { should contain_nagios__resource__command('localcommand') }
      it { expect(exported_resources).to contain_nagios_command('localcommand') }
      it { expect(exported_resources).to contain_file("#{conf_path}/command_#{facts['fqdn']}_localcommand.cfg") }

      it { should contain_nagios__resource('localcontact').with(
        'resource_type'      => 'contact',
        'defaultresourcedef' => {
          'use'              => 'defaultcontact',
        },
      ) }
      it { should contain_nagios__resource__contact('localcontact') }
      it { expect(exported_resources).to contain_nagios_contact('localcontact') }
      it { expect(exported_resources).to contain_file("#{conf_path}/contact_#{facts['fqdn']}_localcontact.cfg") }

      it { should contain_nagios__resource('localcontactgroup').with(
        'resource_type'      => 'contactgroup',
        'defaultresourcedef' => {
          'use'              => 'defaultcontactgroup',
        },
      ) }
      it { should contain_nagios__resource__contactgroup('localcontactgroup') }
      it { expect(exported_resources).to contain_nagios_contactgroup('localcontactgroup') }
      it { expect(exported_resources).to contain_file("#{conf_path}/contactgroup_#{facts['fqdn']}_localcontactgroup.cfg") }

      it { should contain_nagios__resource('localhostgroup').with(
        'resource_type'      => 'hostgroup',
        'defaultresourcedef' => {
          'use'              => 'defaulthostgroup',
        },
      ) }
      it { should contain_nagios__resource__hostgroup('localhostgroup') }
      it { expect(exported_resources).to contain_nagios_hostgroup('localhostgroup') }
      it { expect(exported_resources).to contain_file("#{conf_path}/hostgroup_#{facts['fqdn']}_localhostgroup.cfg") }

      it { should contain_nagios__resource('templatecontact').with(
        'resource_type' => 'contact',
      ) }
      it { should contain_nagios__resource__contact('templatecontact') }
      it { expect(exported_resources).to contain_nagios_contact('templatecontact') }
      it { expect(exported_resources).to contain_file("#{conf_path}/contact_#{facts['fqdn']}_templatecontact.cfg") }

      it { should contain_nagios__resource('templatehost').with(
        'resource_type' => 'host',
      ) }
      it { should contain_nagios__resource__host('templatehost') }
      it { expect(exported_resources).to contain_nagios_host('templatehost') }
      it { expect(exported_resources).to contain_file("#{conf_path}/host_#{facts['fqdn']}_templatehost.cfg") }

      it { should contain_nagios__resource('templateservice').with(
        'resource_type' => 'service',
      ) }
      it { should contain_nagios__resource__service('templateservice') }
      it { expect(exported_resources).to contain_nagios_service('templateservice') }
      it { expect(exported_resources).to contain_file("#{conf_path}/service_#{facts['fqdn']}_templateservice.cfg") }

      it { should contain_nagios__resource('templatetimeperiod').with(
        'resource_type' => 'timeperiod',
      ) }
      it { should contain_nagios__resource__timeperiod('templatetimeperiod') }
      it { expect(exported_resources).to contain_nagios_timeperiod('templatetimeperiod') }
      it { expect(exported_resources).to contain_file("#{conf_path}/timeperiod_#{facts['fqdn']}_templatetimeperiod.cfg") }
    end

  end
end

# vim: ts=2 sw=2 sts=2 et :
