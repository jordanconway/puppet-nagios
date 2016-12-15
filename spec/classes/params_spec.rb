require 'spec_helper'
describe 'nagios::params' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    context "on #{os} with defaults for all parameters" do
      it { should contain_class('nagios::params') }
    end
  end
end

# vim: ts=2 sw=2 sts=2 et :
