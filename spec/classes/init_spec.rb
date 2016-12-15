require 'spec_helper'

describe 'nagios' do
  let(:conf_path) { '/etc/nagios/conf.d' }
  on_supported_os.each do |os,facts|
    let(:facts) do
      facts
    end

    context "on #{os} with defaults for all parameters" do
      it { should contain_class('nagios') }
      it { should contain_anchor('nagios::begin') }
      it { should contain_class('nagios::server::install') }
      it { should contain_class('nagios::server::config') }
      it { should contain_class('nagios::server::service') }
      it { should contain_anchor('nagios::end') }

      # our testing will only cause the default nagios::resources to
      # render from the top most class, so we need to validate them here

      # command
      [
        'check-host-alive',
        'check_dhcp',
        'check_ftp',
        'check_hpjd',
        'check_http',
        'check_imap',
        'check_local_disk',
        'check_local_load',
        'check_local_mrtgtraf',
        'check_local_procs',
        'check_local_swap',
        'check_local_users',
        'check_nt',
        'check_ping',
        'check_pop',
        'check_smtp',
        'check_ssh',
        'check_snmp',
        'check_tcp',
        'check_udp',
        'notify-host-by-email',
        'notify-host-by-epager',
        'notify-service-by-email',
        'notify-service-by-epager',
        'process-host-perfdata',
        'process-service-perfdata'
      ].each do |nag_resource|
        it { should contain_nagios__resource(nag_resource) }
        it { should contain_nagios__resource__command(nag_resource) }
        it { expect(exported_resources).to contain_nagios_command(nag_resource) }
        it { expect(exported_resources).to contain_file("#{conf_path}/command_#{facts['fqdn']}_#{nag_resource.downcase.tr(' ', '_')}.cfg") }
      end

      # contact
      [
        'generic-contact',
        'nagiosadmin'
      ].each do |nag_resource|
        it { should contain_nagios__resource(nag_resource) }
        it { should contain_nagios__resource__contact(nag_resource) }
        it { expect(exported_resources).to contain_nagios_contact(nag_resource) }
        it { expect(exported_resources).to contain_file("#{conf_path}/contact_#{facts['fqdn']}_#{nag_resource.downcase.tr(' ', '_')}.cfg") }
      end

      # contactgroup
      [
        'admins'
      ].each do |nag_resource|
        it { should contain_nagios__resource(nag_resource) }
        it { should contain_nagios__resource__contactgroup(nag_resource) }
        it { expect(exported_resources).to contain_nagios_contactgroup(nag_resource) }
        it { expect(exported_resources).to contain_file("#{conf_path}/contactgroup_#{facts['fqdn']}_#{nag_resource.downcase.tr(' ', '_')}.cfg") }
      end

      # host
      [
        'generic-host',
        'generic-printer',
        'generic-router',
        'generic-switch',
        'linux-server',
        'windows-server'
      ].each do |nag_resource|
        it { should contain_nagios__resource(nag_resource) }
        it { should contain_nagios__resource__host(nag_resource) }
        it { expect(exported_resources).to contain_nagios_host(nag_resource) }
        it { expect(exported_resources).to contain_file("#{conf_path}/host_#{facts['fqdn']}_#{nag_resource.downcase.tr(' ', '_')}.cfg") }
      end


      # hostgroup
      [
        'Other'
      ].each do |nag_resource|
        it { should contain_nagios__resource(nag_resource) }
        it { should contain_nagios__resource__hostgroup(nag_resource) }
        it { expect(exported_resources).to contain_nagios_hostgroup(nag_resource) }
        it { expect(exported_resources).to contain_file("#{conf_path}/hostgroup_#{facts['fqdn']}_#{nag_resource.downcase.tr(' ', '_')}.cfg") }
      end

      # service
      [
        'generic-service',
        'local-service'
      ].each do |nag_resource|
        it { should contain_nagios__resource(nag_resource) }
        it { should contain_nagios__resource__service(nag_resource) }
        it { expect(exported_resources).to contain_nagios_service(nag_resource) }
        it { expect(exported_resources).to contain_file("#{conf_path}/service_#{facts['fqdn']}_#{nag_resource.downcase.tr(' ', '_')}.cfg") }
      end

      # timeperiod
      [
        '24x7',
        'none',
        'workhours'
      ].each do |nag_resource|
        it { should contain_nagios__resource(nag_resource) }
        it { should contain_nagios__resource__timeperiod(nag_resource) }
        it { expect(exported_resources).to contain_nagios_timeperiod(nag_resource) }
        it { expect(exported_resources).to contain_file("#{conf_path}/timeperiod_#{facts['fqdn']}_#{nag_resource.downcase.tr(' ', '_')}.cfg") }
      end

    end
  end
end

# vim: ts=2 sw=2 sts=2 et :
