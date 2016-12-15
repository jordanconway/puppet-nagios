require 'spec_helper'

describe 'nagios::resource', :type => :define do
  let(:title) { 'Test me' }

  let(:conf_path) { '/etc/nagios/conf.d' }
  let(:ltitle) { title.downcase.tr(' ', '_') }

  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    # we do not have defaults for some parameters so the define should fail
    context "on #{os} with defaults for all parameters" do
      let (:params) {{}}

      it do
        expect {
          should compile
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    # With "good" params
    context "on #{os} with good params" do
      let(:params) {
        {
          'resource_type' => 'command',
          'nagiostag'   => 'nagios-foo',
        }
      }

      it { should compile }

      it 'should fail on bad type' do
        params.merge!({'resource_type' => 'badvalue'})
        expect { should compile }.to \
          raise_error(RSpec::Expectations::ExpectationNotMetError,
            /Unknown resource type passed of 'badvalue'/)
      end

      it 'should have a properly defined command resource' do
        params.merge!({ 'resourcedef' => {
          'command_line' => 'testcommand',
        }})
        should contain_nagios__resource__command(title).with(
          'resourcedef'      => {
              'ensure'       => 'present',
              'command_line' => 'testcommand',
              'target'       => "/etc/nagios/conf.d/command_#{facts['fqdn']}_#{ltitle}.cfg",
              'tag'          => 'nagios-foo',
          },
        )

        expect(exported_resources).to contain_nagios_command(title)
        expect(exported_resources).to contain_file("#{conf_path}/command_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have contact define when resource_type => contact' do
        params.merge!({ 'resource_type' => 'contact' })
        should contain_nagios__resource__contact(title)
        expect(exported_resources).to contain_nagios_contact(title)
        expect(exported_resources).to contain_file("#{conf_path}/contact_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have contactgroup define when resource_type => contactgroup' do
        params.merge!({ 'resource_type' => 'contactgroup' })
        should contain_nagios__resource__contactgroup(title)
        expect(exported_resources).to contain_nagios_contactgroup(title)
        expect(exported_resources).to contain_file("#{conf_path}/contactgroup_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have host define when type => host' do
        params.merge!({ 'resource_type' => 'host' })
        should contain_nagios__resource__host(title)
        expect(exported_resources).to contain_nagios_host(title)
        expect(exported_resources).to contain_file("#{conf_path}/host_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have hostdependency define when resource_type => hostdependency' do
        params.merge!({ 'resource_type' => 'hostdependency' })
        should contain_nagios__resource__hostdependency(title)
        expect(exported_resources).to contain_nagios_hostdependency(title)
        expect(exported_resources).to contain_file("#{conf_path}/hostdependency_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have hostescalation define when resource_type => hostescalation' do
        params.merge!({ 'resource_type' => 'hostescalation' })
        should contain_nagios__resource__hostescalation(title)
        expect(exported_resources).to contain_nagios_hostescalation(title)
        expect(exported_resources).to contain_file("#{conf_path}/hostescalation_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have hostextinfo define when resource_type => hostextinfo' do
        params.merge!({ 'resource_type' => 'hostextinfo'})
        should contain_nagios__resource__hostextinfo(title)
        expect(exported_resources).to contain_nagios_hostextinfo(title)
        expect(exported_resources).to contain_file("#{conf_path}/hostextinfo_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have hostgroup define when resource_type => hostgroup' do
        params.merge!({ 'resource_type' => 'hostgroup'})
        should contain_nagios__resource__hostgroup(title)
        expect(exported_resources).to contain_nagios_hostgroup(title)
        expect(exported_resources).to contain_file("#{conf_path}/hostgroup_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have service define when resource_type => service' do
        params.merge!({ 'resource_type' => 'service'})
        should contain_nagios__resource__service(title)
        expect(exported_resources).to contain_nagios_service(title)
        expect(exported_resources).to contain_file("#{conf_path}/service_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have servicedependency define when resource_type => servicedependency' do
        params.merge!({ 'resource_type' => 'servicedependency'})
        should contain_nagios__resource__servicedependency(title)
        expect(exported_resources).to contain_nagios_servicedependency(title)
        expect(exported_resources).to contain_file("#{conf_path}/servicedependency_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have serviceescalation define when resource_type => serviceescalation' do
        params.merge!({ 'resource_type' => 'serviceescalation'})
        should contain_nagios__resource__serviceescalation(title)
        expect(exported_resources).to contain_nagios_serviceescalation(title)
        expect(exported_resources).to contain_file("#{conf_path}/serviceescalation_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have serviceextinfo define when resource_type => serviceextinfo' do
        params.merge!({ 'resource_type' => 'serviceextinfo'})
        should contain_nagios__resource__serviceextinfo(title)
        expect(exported_resources).to contain_nagios_serviceextinfo(title)
        expect(exported_resources).to contain_file("#{conf_path}/serviceextinfo_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have servicegroup define when resource_type => servicegroup' do
        params.merge!({ 'resource_type' => 'servicegroup'})
        should contain_nagios__resource__servicegroup(title)
        expect(exported_resources).to contain_nagios_servicegroup(title)
        expect(exported_resources).to contain_file("#{conf_path}/servicegroup_#{facts['fqdn']}_#{ltitle}.cfg")
      end

      it 'should have timeperiod define when resource_type => timeperiod' do
        params.merge!({ 'resource_type' => 'timeperiod'})
        should contain_nagios__resource__timeperiod(title)
        expect(exported_resources).to contain_nagios_timeperiod(title)
        expect(exported_resources).to contain_file("#{conf_path}/timeperiod_#{facts['fqdn']}_#{ltitle}.cfg")
      end
    end
  end
end

# vim: ts=2 sw=2 sts=2 et :
