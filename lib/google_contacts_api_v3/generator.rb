module GContactParser
  class Generator
    attr_reader :version, :uri, :name

    def initialize(args)
      @version = args[:version]
      @uri = args[:uri]
      @name = args[:name]
    end

    def self.create_from_json(json_map)
      Generator.new(:version => json_map['version'],
        :uri => json_map['uri'],
        :name => json_map['$t'])
    end
  end # class Generator
end # module GContactParser
