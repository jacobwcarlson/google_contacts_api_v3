$LOAD_PATH.push File.dirname __FILE__
$LOAD_PATH.push File.dirname(__FILE__) + "/.."
$LOAD_PATH.push File.dirname(__FILE__) + "/../../lib"

require 'test_data_loader'
require "google_contacts_api_v3"

include GoogleContactsApiV3
