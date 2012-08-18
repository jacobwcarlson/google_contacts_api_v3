module GoogleContactsApiV3
  require 'util'

  class Im
    attr_reader :address, :label, :rel, :protocol, :primary
    alias :type :rel

    def initialize(args)
      @address = args[:address]
      @label = args[:label]
      @primary = args[:primary]
      @protocol = args[:protocol]
      @rel = args[:rel]

      @lable ||= @rel
    end

    def self.create_from_json(json_map)
      protocol = json_map['protocol'].to_s.split("#").last
      Im.new(:address => json_map['address'],
             :label => json_map['label'],
             :primary => Util.is_true?(json_map['primary']),
             :protocol => protocol,
             :rel => json_map['rel'].to_s.split("#").last)
    end
  end # class Im
end # module GoogleContactsApiV3
