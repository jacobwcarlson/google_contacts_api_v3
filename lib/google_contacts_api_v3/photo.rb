module GoogleContactsApiV3
  class Photo
    attr_reader :rel, :type, :href, :etag

    def initialize(args)
      @rel = args[:rel]
      @type = args[:type]
      @href = args[:href]
      @etag = args[:etag]
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      Photo.new(:rel => json_map['rel'], :type => json_map['type'],
        :href => json_map['href'], :etag => json_map['gd$etag'])
    end
  end # class Photo
end # module GContactsApiV3
