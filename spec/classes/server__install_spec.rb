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
    it { should contain_file('/usr/lib/systemd/system/nagios.service').with(
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
      'content' => '[Unit]
Description=Nagios Network Monitoring
After=network.target
Documentation=https://www.nagios.org/documentation/

[Service]
Type=forking
User=nagios
Group=nagios
PIDFile=/var/run/nagios/nagios.pid
# Verify Nagios config before start as upstream suggested
ExecStartPre=/usr/sbin/nagios -v /etc/nagios/nagios.cfg
ExecStart=/usr/sbin/nagios -d /etc/nagios/nagios.cfg
ExecStopPost=/usr/bin/rm -f /var/spool/nagios/cmd/nagios.cmd
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
',
    ) }
  end
end

# vim: ts=2 sw=2 sts=2 et :
