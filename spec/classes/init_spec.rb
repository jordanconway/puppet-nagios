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
    it { should contain_class('nagios::server::service') }
    it { should contain_anchor('nagios::end') }

    # our testing will only cause the default nagios::resources to
    # render from the top most class, so we need to validate them here
    it { should contain_nagios__resource('24x7') }
    it { should contain_nagios__resource('Other') }
    it { should contain_nagios__resource('admins') }
    it { should contain_nagios__resource('check-host-alive') }
    it { should contain_nagios__resource('check_dhcp') }
    it { should contain_nagios__resource('check_ftp') }
    it { should contain_nagios__resource('check_hpjd') }
    it { should contain_nagios__resource('check_http') }
    it { should contain_nagios__resource('check_imap') }
    it { should contain_nagios__resource('check_local_disk') }
    it { should contain_nagios__resource('check_local_load') }
    it { should contain_nagios__resource('check_local_mrtgtraf') }
    it { should contain_nagios__resource('check_local_procs') }
    it { should contain_nagios__resource('check_local_swap') }
    it { should contain_nagios__resource('check_local_users') }
    it { should contain_nagios__resource('check_nt') }
    it { should contain_nagios__resource('check_ping') }
    it { should contain_nagios__resource('check_pop') }
    it { should contain_nagios__resource('check_smtp') }
    it { should contain_nagios__resource('check_ssh') }
    it { should contain_nagios__resource('check_snmp') }
    it { should contain_nagios__resource('check_tcp') }
    it { should contain_nagios__resource('check_udp') }
    it { should contain_nagios__resource('generic-contact') }
    it { should contain_nagios__resource('generic-host') }
    it { should contain_nagios__resource('generic-printer') }
    it { should contain_nagios__resource('generic-router') }
    it { should contain_nagios__resource('generic-service') }
    it { should contain_nagios__resource('generic-switch') }
    it { should contain_nagios__resource('linux-server') }
    it { should contain_nagios__resource('local-service') }
    it { should contain_nagios__resource('nagiosadmin') }
    it { should contain_nagios__resource('none') }
    it { should contain_nagios__resource('notify-host-by-email') }
    it { should contain_nagios__resource('notify-host-by-epager') }
    it { should contain_nagios__resource('notify-service-by-email') }
    it { should contain_nagios__resource('notify-service-by-epager') }
    it { should contain_nagios__resource('process-host-perfdata') }
    it { should contain_nagios__resource('process-service-perfdata') }
    it { should contain_nagios__resource('windows-server') }
    it { should contain_nagios__resource('workhours') }
  end

end

# vim: ts=2 sw=2 sts=2 et :
