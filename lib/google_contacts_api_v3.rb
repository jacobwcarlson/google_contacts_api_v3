$:.unshift File.join(File.dirname(__FILE__), '.', './google_contacts_api_v3')
require 'json'
require 'oauth'
require 'date'

module GoogleContactsApiV3
  require 'author'
  require 'category'
  require 'connection'
  require 'contact'
  require 'contact_name'
  require 'email_address'
  require 'event'
  require 'feed'
  require 'generator'
  require 'im'
  require 'link'
  require 'organization'
  require 'phone_number'
  require 'postal_address'
  require 'response'
  require 'version'
  require 'website'
end # module GoogleContactsApiV3
