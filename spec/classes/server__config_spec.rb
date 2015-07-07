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
      'path'    => '/etc/nagios/objects',
      'purge'   => true,
      'recurse' => true,
    ).that_comes_before('Class[nagios::server::config::import]') }
  end
end

# vim: ts=2 sw=2 sts=2 et :
