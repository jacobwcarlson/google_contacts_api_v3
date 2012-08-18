# See https://developers.google.com/gdata/docs/2.0/elements#gdPhoneNumber
# for details on what these field mean
module GoogleContactsApiV3
  require 'util'

  class PhoneNumber
    attr_reader :label, :rel, :uri, :primary, :as_text
    alias :type :rel

    def initialize(args)
      @label = args[:label]
      @rel = args[:rel]
      @uri = args[:uri]
      @primary = args[:primary]
      @as_text = args[:as_text]
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      PhoneNumber.new(:label => json_map['label'],
        :rel => json_map['rel'].to_s.split("#").last,
        :uri => json_map['uri'],
        :primary => Util.is_true?(json_map['primary']),
        :as_text => json_map['$t'])
    end
  end # class PhoneNumber
end # module GoogleContactsApiV3
