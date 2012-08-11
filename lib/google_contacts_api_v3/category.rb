module GoogleContactsApiV3
  class Category
    attr_reader :scheme, :term

    def initialize(args)
      @scheme = args[:scheme]
      @term = args[:term]
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      Category.new(:scheme => json_map['scheme'], :term => json_map['term'])
    end
  end # class Category
end # module GContactParser
