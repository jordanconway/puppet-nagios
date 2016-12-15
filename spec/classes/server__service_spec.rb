require 'spec_helper'

describe 'nagios::server::service' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    context "on #{os} with defaults for all parameters" do
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
end

# vim: ts=2 sw=2 sts=2 et :
