module GoogleContactsApiV3
  require 'util'

  class EmailAddress
    attr_accessor :address, :display_name, :label, :primary, :rel, :type

    def self.create_from_json(json)
      EmailAddress.new.tap do |email|
        email.address = json['address']
        email.display_name = json['displayName']
        email.label = json['label']
        email.primary = json['primary'] == "true"
        email.rel = json['rel']
        email.type = json['rel'].to_s.split("#").last
      end.freeze
    end
  end # class EmailAddress
end #module GContactParser
