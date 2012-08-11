module GoogleContactsApiV3
  require 'util'

  class ContactName
    attr_reader :full_name, :given_name, :family_name

    def initialize(args)
      @full_name = args[:full_name]
      @given_name = args[:given_name]
      @family_name = args[:family_name]
    end

    def self.create_from_json(json_map)
      ContactName.new(:full_name => Util.get_hash_val(json_map, 'gd$fullName'),
        :given_name => Util.get_hash_val(json_map, 'gd$givenName'),
        :family_name => Util.get_hash_val(json_map, 'gd$familyName'))
    end
  end # class ContactName
end #module GoogleContactsApiV3
