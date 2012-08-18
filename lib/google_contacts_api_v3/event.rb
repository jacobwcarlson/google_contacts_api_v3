# See https://developers.google.com/google-apps/contacts/v3/reference#gcEvent
# for details on what these field mean
module GoogleContactsApiV3
  require 'util'

  class Event
    attr_reader :label, :rel, :when
    alias :event_time :when

    def initialize(args)
      @label = args[:label]
      @rel = args[:rel]
      @when = args[:when]

      @label ||= @rel
    end

    def self.create_from_json(json_map)
      event_time = nil
      if json_map['gd$when'] && json_map['gd$when']['startTime']
        event_time = DateTime.parse(json_map['gd$when']['startTime'])
      end

      Event.new(:label => json_map['label'],
        :rel => json_map['rel'],
        :when => event_time)
    end
  end # class Event
end # module GoogleContactsApiV3
