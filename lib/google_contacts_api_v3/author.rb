module GoogleContactsApiV3
  require 'util'

  class Author
    attr_reader :name, :email

    def initialize(args)
      @name = args[:name]
      @email = args[:email]
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      Author.new(:name => Util.get_text_val(json_map, 'name'),
                 :email => Util.get_text_val(json_map, 'email'))
    end
  end # class Author
end #module GoogleContactsApiV3
