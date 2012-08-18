module GoogleContactsApiV3
  require 'util'

  class EmailAddress
    attr_reader :address, :display_name, :label, :primary, :rel
    alias :type :rel

    def initialize(args)
      @address = args[:address]
      @display_name = args[:display_name]
      @label = args[:label]
      @primary = args[:primary]
      @rel = args[:rel]

      @label ||= @rel
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      EmailAddress.new(:address => json_map['address'],
        :display_name => json_map['displayName'],
        :label => json_map['label'],
        :primary => Util.is_true?(json_map['primary']),
        :rel => json_map['rel'].to_s.split("#").last)
    end
  end # class EmailAddress
end #module GContactParser
