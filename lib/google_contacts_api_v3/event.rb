# See https://developers.google.com/google-apps/contacts/v3/reference#gcEvent
# for details on what these field mean
module GoogleContactsApiV3
  class Event
    attr_accessor :label, :rel, :when
    alias :event_time :when

    def self.create_from_json(json)
      Event.new.tap do |event|
        json['gd$when'].andand['startTime'].andand.tap do |event_time|
          event.when = DateTime.parse(event_time)
        end

        event.label = json['label']
        event.rel = json['rel']
      end.freeze
    end
  end # class Event
end # module GoogleContactsApiV3
