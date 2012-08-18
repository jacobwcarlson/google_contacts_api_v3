module GoogleContactsApiV3
  require 'util'

  class Website
    attr_reader :href, :label, :rel
    alias :description :label

    def initialize(args)
      @href = args[:href]
      @label = args[:label]
      @rel = args[:rel]

      @label ||= @rel
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      Website.new(:href => json_map['href'],
                  :rel => json_map['rel'],
                  :label => json_map['label'])
    end
  end # class Website
end # module GoogleContactsApiV3
