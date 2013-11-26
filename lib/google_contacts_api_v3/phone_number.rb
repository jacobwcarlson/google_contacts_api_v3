# See https://developers.google.com/gdata/docs/2.0/elements#gdPhoneNumber
# for details on what these field mean
module GoogleContactsApiV3
  require 'util'

  class PhoneNumber
    attr_accessor :label, :rel, :uri, :primary, :as_text, :type

    def initialize
      @primary ||= false
    end

    def self.create_from_json(json)
      PhoneNumber.new.tap do |phone|
        phone.label = json['label']
        phone.type = json['rel'].to_s.split("#").last
        phone.rel = json['rel']
        phone.uri = json['uri']
        phone.primary = json['primary'] == "true"
        phone.as_text = json['$t']
      end.freeze
    end
  end # class PhoneNumber
end # module GoogleContactsApiV3
