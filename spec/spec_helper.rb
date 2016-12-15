require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

include RspecPuppetFacts

# custom global facts
add_custom_fact :fqdn, 'test.example.com'
add_custom_fact :hostname, 'test'
add_custom_fact :ipaddress, '192.168.0.1'

at_exit { RSpec::Puppet::Coverage.report! }

# Turn on more verbose documentation
RSpec.configure do |config|
  config.formatter = :documentation
end
