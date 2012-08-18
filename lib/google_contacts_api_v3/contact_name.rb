module GoogleContactsApiV3
  require 'util'

  class ContactName
    attr_reader :given_name, :additional_name, :family_name
    attr_reader :name_prefix, :name_suffix, :full_name

    alias :prefix :name_prefix
    alias :suffix :name_suffix

    def initialize(args)
      @given_name = args[:given_name]
      @additional_name = args[:additional_name]
      @family_name = args[:family_name]
      @name_prefix = args[:name_prefix]
      @name_suffix = args[:name_suffix]
      @full_name = args[:full_name]
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      ContactName.new(:full_name => Util.get_text_val(json_map, 'gd$fullName'),
        :given_name => Util.get_text_val(json_map, 'gd$givenName'),
        :additional_name => Util.get_text_val(json_map, 'gd$additionalName'),
        :family_name => Util.get_text_val(json_map, 'gd$familyName'),
        :name_prefix => Util.get_text_val(json_map, 'gd$namePrefix'),
        :name_suffix => Util.get_text_val(json_map, 'gd$nameSuffix'))
    end
  end # class ContactName
end #module GoogleContactsApiV3
