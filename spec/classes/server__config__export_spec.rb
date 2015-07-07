require 'spec_helper'
describe 'nagios::server::config::export' do
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
      'type'               => 'command',
      'nagiostag'          => 'test',
      'defaultresourcedef' => {},
      'resourcedef'        => {},
    ) }

    it { should contain_nagios__resource('defaultcontact').with(
      'type' => 'contact',
    ) }

    it { should contain_nagios__resource('defaultcontactgroup').with(
      'type' => 'contactgroup',
    ) }

    it { should contain_nagios__resource('defaulthostgroup').with(
      'type' => 'hostgroup',
    ) }

    it { should contain_nagios__resource('localcommand').with(
      'type'               => 'command',
      'defaultresourcedef' => {
        'use'              => 'defaultcommand',
      },
    ) }

    it { should contain_nagios__resource('localcontact').with(
      'type'               => 'contact',
      'defaultresourcedef' => {
        'use'              => 'defaultcontact',
      },
    ) }

    it { should contain_nagios__resource('localcontactgroup').with(
      'type'               => 'contactgroup',
      'defaultresourcedef' => {
        'use'              => 'defaultcontactgroup',
      },
    ) }

    it { should contain_nagios__resource('localhostgroup').with(
      'type'               => 'hostgroup',
      'defaultresourcedef' => {
        'use'              => 'defaulthostgroup',
      },
    ) }

    it { should contain_nagios__resource('templatecontact').with(
      'type' => 'contact',
    ) }

    it { should contain_nagios__resource('templatehost').with(
      'type' => 'host',
    ) }

    it { should contain_nagios__resource('templateservice').with(
      'type' => 'service',
    ) }

    it { should contain_nagios__resource('templatetimeperiod').with(
      'type' => 'timeperiod',
    ) }
  end

end

# vim: ts=2 sw=2 sts=2 et :
