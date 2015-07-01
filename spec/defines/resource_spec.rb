require 'spec_helper'
describe 'nagios::resource', :type => :define do
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

  # With "good" params
  context 'with good params' do
    let(:params) {
      {
        'type'           => 'command',
        'nagiostag'   => 'nagios-foo',
      }
    }

    it { should compile }

    it 'should fail on bad type' do
      params.merge!({'type' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /Unknown resource type passed of 'badvalue'/)
    end

    it 'should have a propperly defined command resource' do
      params.merge!({ 'resourcedef' => {
        'command_line' => 'testcommand',
      }})
      should contain_nagios__resource__command('Test me').with(
        'resourcedef'      => {
            'ensure'       => 'present',
            'command_line' => 'testcommand',
            'target'       => '/etc/nagios/objects/command_test_me.cfg',
            'tag'          => 'nagios-foo',
        },
      )
    end

    it 'should have contact define when type => contact' do
      params.merge!({ 'type' => 'contact' })
      should contain_nagios__resource__contact('Test me')
    end

    it 'should have contactgroup define when type => contactgroup' do
      params.merge!({ 'type' => 'contactgroup' })
      should contain_nagios__resource__contactgroup('Test me')
    end

    it 'should have host define when type => host' do
      params.merge!({ 'type' => 'host' })
      should contain_nagios__resource__host('Test me')
    end

    it 'should have hostdependency define when type => hostdependency' do
      params.merge!({ 'type' => 'hostdependency' })
      should contain_nagios__resource__hostdependency('Test me')
    end

    it 'should have hostescalation define when type => hostescalation' do
      params.merge!({ 'type' => 'hostescalation' })
      should contain_nagios__resource__hostescalation('Test me')
    end

    it 'should have hostextinfo define when type => hostextinfo' do
      params.merge!({ 'type' => 'hostextinfo'})
      should contain_nagios__resource__hostextinfo('Test me')
    end

    it 'should have hostgroup define when type => hostgroup' do
      params.merge!({ 'type' => 'hostgroup'})
      should contain_nagios__resource__hostgroup('Test me')
    end

    it 'should have service define when type => service' do
      params.merge!({ 'type' => 'service'})
      should contain_nagios__resource__service('Test me')
    end

    it 'should have servicedependency define when type => servicedependency' do
      params.merge!({ 'type' => 'servicedependency'})
      should contain_nagios__resource__servicedependency('Test me')
    end

    it 'should have serviceescalation define when type => serviceescalation' do
      params.merge!({ 'type' => 'serviceescalation'})
      should contain_nagios__resource__serviceescalation('Test me')
    end

    it 'should have serviceextinfo define when type => serviceextinfo' do
      params.merge!({ 'type' => 'serviceextinfo'})
      should contain_nagios__resource__serviceextinfo('Test me')
    end

    it 'should have servicegroup define when type => servicegroup' do
      params.merge!({ 'type' => 'servicegroup'})
      should contain_nagios__resource__servicegroup('Test me')
    end

    it 'should have timeperiod define when type => timeperiod' do
      params.merge!({ 'type' => 'timeperiod'})
      should contain_nagios__resource__timeperiod('Test me')
    end

  end
end

# vim: ts=2 sw=2 sts=2 et :
