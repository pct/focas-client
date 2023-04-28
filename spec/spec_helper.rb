require "bundler/setup"
require "focas-client"

Focas.configure do |configure|
  configure.production_mode = 0
  configure.mer_id = ENV.fetch('merID', nil)
  configure.merchant_id = ENV.fetch('MerchantID', nil)
  configure.terminal_id = ENV.fetch('TerminalID', nil)
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
