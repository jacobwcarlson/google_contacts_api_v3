$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'spec_helper'
require 'google_contacts_api_v3'
include GoogleContactsApiV3

describe GoogleContactsApiV3 do
  before :each do
    begin
      require 'test_data/credentials'
    rescue  # Warnings are printed in the individual tests.
    end

  end

  it "should successfully connect" do
    pending(CREDENTIALS_SETUP_INSTRUCTIONS, :unless => check_credentials)

    conn = Connection.new(:user_token => USER_AUTH_ATTRS[:token],
      :user_secret => USER_AUTH_ATTRS[:secret],
      :consumer_token => CONSUMER_AUTH_ATTRS[:token],
      :consumer_secret => CONSUMER_AUTH_ATTRS[:secret])
 
    conn.ping.should be_true
  end

  it "should successfully retrieve contacts" do
    pending(CREDENTIALS_SETUP_INSTRUCTIONS, :unless => check_credentials)

    conn = Connection.new(:user_token => USER_AUTH_ATTRS[:token],
      :user_secret => USER_AUTH_ATTRS[:secret],
      :consumer_token => CONSUMER_AUTH_ATTRS[:token],
      :consumer_secret => CONSUMER_AUTH_ATTRS[:secret])
 
    contacts = conn.get_contacts
    conn.message.should_not be_nil
    contacts.should_not be_nil
    contacts.class.should eq Array
  end
end
