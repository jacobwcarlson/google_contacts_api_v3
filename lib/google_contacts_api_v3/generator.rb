module GContactParser
  class Generator
    attr_accessor :version, :uri, :name

    def self.create_from_json(json)
      return nil unless json

      Generator.new.tap do |generator|
        generator.version = json_map['version']
        generator.uri = json_map['uri']
        generator.name = json_map['$t']
      end.freeze
    end
  end # class Generator
end # module GContactParser
