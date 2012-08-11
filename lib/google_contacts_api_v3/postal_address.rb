module GoogleContactsApiV3
  require 'util'
  class PostalAdddress
    attr_reader :formatted_address, :street, :city, :region

    def initialize(args)
      @formatted_address = args[:formatted_address]
      @street = args[:street]
      @city = args[:city]
      @region = args[:state]
    end

    def self.create_from_json(json_map)
      PostalAddress.new(:street => get_tval(json_map, 'gd$street'),
        :formatted_address => get_tval(json_map, 'gd$formattedAddress'),
        :city => get_tval(json_map, 'gd$city'),
        :region => get_tval(json_map, 'gd$region'))
    end
  end # class PostalAddress
end # module GoogleContactsApiV3
