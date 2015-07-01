require 'spec_helper'
describe 'nagios::resource::command', :type => :define do
  let(:title) { 'Test me' }
  let(:facts) {
    {
      :fqdn            => 'test.example.com',
      :hostname        => 'test',
      :ipaddress       => '192.168.0.1',
      :operatingsystem => 'CentOS',
      :osfamily        => 'RedHat'
    }
  }

  # we do not have defaults for some parameters so the define should fail
  context 'with defaults for all parameters' do
    let (:params) {{}}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass /)
    end
  end

  # nagios::resource::command only exports a nagios_command object
  # since rspec can't test for exported objects we can't test that this is valid :(
end
# vim: ts=2 sw=2 sts=2 et :
