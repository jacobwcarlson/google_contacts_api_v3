module GoogleContactsApiV3
  require 'util'

  class ContactName
    attr_accessor :given_name, :additional_name, :family_name
    attr_accessor :name_prefix, :name_suffix, :full_name

    alias :prefix :name_prefix
    alias :suffix :name_suffix

    def self.create_from_json(json)
      ContactName.new.tap do |name|
        name.full_name = json['gd$fullName'].andand['$t']
        name.given_name = json['gd$givenName'].andand['$t']
        name.additional_name = json['gd$additionalName'].andand['$t']
        name.family_name = json['gd$familyName'].andand['$t']
        name.name_prefix = json['gd$namePrefix'].andand['$t']
        name.name_suffix = json['gd$nameSuffix'].andand['$t']
      end.freeze
    end
  end # class ContactName
end #module GoogleContactsApiV3
