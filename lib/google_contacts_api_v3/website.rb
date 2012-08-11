module GoogleContactsApiV3
  require 'util'

  class Website
    attr_reader :href, :description

    def intialize(args)
      @href = args[:href]
      @description = args[:rel]
    end

    def self.create_from_json(json_map)
      Website.new(:href => json_map['href'],
        :description => json_map['rel'])
    end
  end # class Website
end # module GoogleContactsApiV3
