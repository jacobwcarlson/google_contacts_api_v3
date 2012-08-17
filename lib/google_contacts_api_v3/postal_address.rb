module GoogleContactsApiV3
  require 'util'
  class PostalAddress
    attr_reader :formatted_address, :street, :city, :region

    def initialize(args)
      @formatted_address = args[:formatted_address]
      @street = args[:street]
      @city = args[:city]
      @region = args[:region]
    end

    def self.create_from_json(json_map)
      return nil unless json_map
      PostalAddress.new(:street => Util.get_hash_val(json_map, 'gd$street'),
        :formatted_address => Util.get_hash_val(json_map, 'gd$formattedAddress'),
        :city => Util.get_hash_val(json_map, 'gd$city'),
        :region => Util.get_hash_val(json_map, 'gd$region'))
    end
  end # class PostalAddress
end # module GoogleContactsApiV3
