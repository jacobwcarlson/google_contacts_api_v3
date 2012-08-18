# See https://developers.google.com/gdata/docs/2.0/elements#gdStructuredPostalAddress
# for details on what these field mean
module GoogleContactsApiV3
  require 'util'
  class PostalAddress
    attr_reader :formatted_address, :street, :city, :region
    attr_reader :rel, :mail_class, :usage, :label, :primary
    attr_reader :agent, :housename, :pobox, :neighborhood
    attr_reader :subregion, :post_code, :country, :rel
    alias :type :rel

    def initialize(args)
      @agent = args[:agent]
      @city = args[:city]
      @country = args[:country]
      @formatted_address = args[:formatted_address]
      @housename = args[:housename]
      @label = args[:label]
      @mail_class = args[:mail_class]
      @neighborhood = args[:neighborhood]
      @pobox = args[:pobox]
      @post_code = args[:post_code]
      @primary = args[:primary]
      @region = args[:region]
      @rel = args[:rel]
      @street = args[:street]
      @subregion = args[:subregion]
      @usage = args[:usage]

      @label ||= @rel
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      # The country field can have a 'code', a '$t', or both.
      # The Code is preferable so look for that first.
      country = nil
      if json_map['gd$country']
        country = json_map['gd$country']['code']
        country ||= json_map['gd$country']['$t']
      end
      PostalAddress.new(:agent => Util.get_text_val(json_map, "gd$agent"),
        :city => Util.get_text_val(json_map, "gd$city"),
        :country => country,
        :housename => Util.get_text_val(json_map, "gd$housename"),
        :label => Util.get_text_val(json_map, "label"),
        :mail_class => Util.get_text_val(json_map, "mailClass"),
        :neighborhood => Util.get_text_val(json_map, "gd$neighborhood"),
        :pobox => Util.get_text_val(json_map, "gd$pobox"),
        :post_code => Util.get_text_val(json_map, "gd$postcode"),
        :primary => Util.get_text_val(json_map, "primary"),
        :region => Util.get_text_val(json_map, "gd$region"),
        :rel => json_map["rel"].to_s.split("#").last,
        :street => Util.get_text_val(json_map, "gd$street"),
        :subregion => Util.get_text_val(json_map, "gd$subregion"),
        :usage => Util.get_text_val(json_map, "usage"),
        :formatted_address => Util.get_text_val(json_map,
                                                "gd$formattedAddress"))
    end
  end # class PostalAddress
end # module GoogleContactsApiV3
