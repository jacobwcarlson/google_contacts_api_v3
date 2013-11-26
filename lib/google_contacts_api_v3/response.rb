module GoogleContactsApiV3
  class Response
    attr_accessor :version, :encoding, :feed

    def self.create_from_json(json)
      Response.new.tap do |response|
        response.version = json['version']
        response.encoding = json['encoding']
        response.feed = Feed.create_from_json json['feed']
      end.freeze
    end
  end # class Response
end # module GContactParser
