module GoogleContactsApiV3
  class Response
    attr_reader :version, :encoding, :feed

    def initialize(args)
      @version = args[:version].to_s
      @encoding = args[:encoding].to_s
      @feed = args[:feed]
    end

    def self.create_from_json(json_map)
      Response.new(:version => json_map['version'],
        :encoding => json_map['encoding'],
        :feed => Feed.create_from_json(json_map['feed']))
    end
  end # class Response
end # module GContactParser
