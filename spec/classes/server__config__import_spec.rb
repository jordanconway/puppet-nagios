require 'spec_helper'
describe 'nagios::server::config::import' do
  on_supported_os.each do |os, facts|
    let(:facts) do
      facts
    end

    # we do not have default values so the class should fail compile
    context "on #{os} with defaults for all parameters" do
      let (:params) {{}}

      it do
        expect {
          should compile
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end

    context "on #{os} with basic init defaults" do
      let (:params) {
        {
          'nagiostag' => '',
        }
      }

      it { should contain_class('nagios::server::config::import') }

      # We can't do any more tests since the rest of this class does
      # resource collection only and rspec can't test that :(
    end
  end
end

# vim: ts=2 sw=2 sts=2 et :
