module GoogleContactsApiV3
  class Link
    attr_reader :rel, :type, :href

    def initialize(args)
      @rel = args[:rel]
      @type = args[:type]
      @href = args[:href]
    end

    def self.create_from_json(json_map)
      Link.new(:rel => json_map['rel'], :type => json_map['type'],
        :href => json_map['href'])
    end
  end # class Link
end # module GContactParser
