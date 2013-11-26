module GoogleContactsApiV3
  require 'util'

  class Im
    attr_accessor :address, :label, :rel, :protocol, :primary, :type

    def self.create_from_json(json)
      Im.new.tap do |im|
        im.address = json['address']
        im.label = json['label']
        im.primary = json['primary'] == "true"
        im.protocol = json['protocol'].to_s.split("#").last
        im.rel = json['rel']
        im.type = json['rel'].to_s.split("#").last
      end.freeze
    end
  end # class Im
end # module GoogleContactsApiV3
