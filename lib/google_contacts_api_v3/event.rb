# See https://developers.google.com/google-apps/contacts/v3/reference#gcEvent
# for details on what these field mean
module GoogleContactsApiV3
  class Event
    attr_accessor :label, :rel, :when
    alias :event_time :when

    def self.create_from_json(json)
      return nil unless json

      Event.new.tap do |event|
        event.when = json['gd$when'].andand['startTime'].andand do |start_time|
          DateTime.parse(start_time)
        end

        event.label = json['label']
        event.rel = json['rel']
      end.freeze
    end
  end # class Event
end # module GoogleContactsApiV3
