require 'spec_helper'
describe 'nagios::params' do
  # Force our osfamily so that our params class doesn't croak
  let(:facts) {
    {
      :osfamily => 'RedHat'
    }
  }

  context 'with defaults for all parameters' do
    it { should contain_class('nagios::params') }
  end
end

# vim: ts=2 sw=2 sts=2 et :
