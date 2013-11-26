# See https://developers.google.com/gdata/docs/2.0/elements#gdStructuredPostalAddress
# for details on what these field mean
module GoogleContactsApiV3
  require 'util'
  class PostalAddress
    attr_accessor :formatted_address, :street, :city, :region
    attr_accessor :rel, :mail_class, :usage, :label, :primary
    attr_accessor :agent, :housename, :pobox, :neighborhood
    attr_accessor :subregion, :post_code, :country, :rel, :type

    def initialize
      @mail_class ||= "both"
      @primary ||= false
    end

    def self.create_from_json(json)
      PostalAddress.new.tap do |address|
        address.agent = json['gd$agent']
        address.city = json['gd$city']
        address.country = json['gd$country'].andand{|c| c['code'] || c['$t']}
        address.housename = json['gd$housename']
        address.label = json['label']
        address.mail_class = json['mailClass']
        address.neighborhood = json['gd$neighborhood']
        address.pobox = json['gd$pobox']
        address.post_code = json['gd$postcode']
        address.primary = json['primary'] == "true"
        address.region = json['gd$region']
        address.rel = json["rel"]
        address.type = json["rel"].to_s.split("#").last,
        address.street = json['gd$street']
        address.subregion = json['gd$subregion']
        address.usage = json['usage']
        address.formatted_address = json['gd$formattedAddress']
      end.freeze
    end
  end # class PostalAddress
end # module GoogleContactsApiV3
