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
    it { should contain_anchor('nagios::begin') }
    it { should contain_class('nagios::server::install') }
    it { should contain_class('nagios::server::config') }
    #it { should contain_class('nagios::server::service') }
    it { should contain_anchor('nagios::end') }
  end

end

# vim: ts=2 sw=2 sts=2 et :
