module GoogleContactsApiV3
  class Website
    attr_accessor :href, :label, :rel
    alias :description :label

    def self.create_from_json(json)
      Website.new.tap do |website|
        website.href = json['href']
        website.rel = json['rel']
        website.label = json['label']
      end.freeze
    end
  end # class Website
end # module GoogleContactsApiV3
