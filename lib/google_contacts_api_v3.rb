$:.unshift File.join(File.dirname(__FILE__), '.', './google_contacts_api_v3')
require 'json'
require 'oauth'

module GoogleContactsApiV3
  require 'author'
  require 'category'
  require 'contact'
  require 'contact_name'
  require 'email_address'
  require 'feed'
  require 'generator'
  require 'link'
  require 'postal_address'
  require 'response'
  require 'version'
  require 'website'
end # module GoogleContactsApiV3
