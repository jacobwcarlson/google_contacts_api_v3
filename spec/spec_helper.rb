def check_credentials
  return false unless USER_AUTH_ATTRS
  return false unless CONSUMER_AUTH_ATTRS

  true
end

CREDENTIALS_SETUP_INSTRUCTIONS = %Q{
  No OAuth credentials found, live testing disabled.
  Please see README.md for details on how to setup your credentials.}

RSpec.configure do |config|
end
