module GoogleContactsApiV3
  class Category
    attr_accessor :scheme, :term

    def self.create_from_json(json)
      return nil unless json

      Category.new.tap do |category|
        category.scheme = json.andand['scheme']
        category.term = json.andand['term']
      end.freeze
    end
  end # class Category
end # module GContactParser
