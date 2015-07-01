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
end

# vim: ts=2 sw=2 sts=2 et :
