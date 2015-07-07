require 'spec_helper'
describe 'nagios::server::install' do
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
        'plugins' => [
          'nagios-plugins-all'
        ],
      }
    }
    it { should contain_class('nagios::server::install') }
    it { should contain_package('nagios') }
    it { should contain_package('nagios-plugins-all') }
  end
end

# vim: ts=2 sw=2 sts=2 et :
