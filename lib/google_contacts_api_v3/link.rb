module GoogleContactsApiV3
  class Link
    attr_accessor :rel, :type, :href

    def self.create_from_json(json)
      Link.new.tap do |link|
        link.rel = json.andand['rel']
        link.type = json.andand['type']
        link.href = json.andand['href']
      end.freeze
    end
  end # class Link
end # module GContactParser
