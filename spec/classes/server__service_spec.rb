require 'spec_helper'
describe 'nagios::server::service' do
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
    it { should contain_class('nagios::server::service') }
    it { should contain_class('nagios::params') }
    it { should contain_service('nagios').with(
      'ensure'     => 'running',
      'enable'     => true,
      'hasrestart' => true,
      'restart'    => 'nagios -v /etc/nagios/nagios.cfg && service nagios reload',
    ) }
  end

end

# vim: ts=2 sw=2 sts=2 et :
