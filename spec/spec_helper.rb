require 'convoy'
require 'fakefs/safe'
require 'fakefs/spec_helpers'

Dir[File.join(File.dirname(__FILE__), 'support', '**', "*.rb").to_s].each { |file| require file }

#helpers
#require 'helpers/exit_with_code_matcher'
#require 'helpers/execute_action_matcher'
#require 'helpers/give_option_to_action_with_value_matcher'
# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered                = true
    config.filter_run :focus

    config.include IntegrationHelpers, :integration => true

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = 'random'
end
