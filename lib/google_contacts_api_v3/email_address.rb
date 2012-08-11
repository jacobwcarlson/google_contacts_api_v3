module GoogleContactsApiV3
  class EmailAddress
    attr_reader :address, :is_primary, :description

    def initialize(args)
      @address = args[:address]
      @is_primary = args[:is_primary]
      @description = args[:description]
    end

    def self.create_from_json(json_map)
      EmailAddress.new(:address => json_map['address'],
        :is_primary => (json_map['primary'] && json_map['primary'] == 'true'),
        :description => json_map['rel'].to_s.split("#").last)
    end
  end # class EmailAddress
end #module GContactParser
