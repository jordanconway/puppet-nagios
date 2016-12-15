require 'spec_helper'

describe 'nagios::resource::host', :type => :define do
  let(:title) { 'Test me' }

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

    # nagios::resource::host only exports a nagios_host object
    # since rspec can't test for exported objects we can't test that this is valid :(
  end
end
# vim: ts=2 sw=2 sts=2 et :
