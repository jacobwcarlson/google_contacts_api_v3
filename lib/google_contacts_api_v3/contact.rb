module GoogleContactsApiV3
  require 'util'
  include GoogleContactsApiV3::Util

  class Contact
    attr_accessor :id_, :name, :updated, :categories, :title, :email_addresses
    attr_accessor :birthday, :notes, :phone_numbers, :postal_addresses
    attr_accessor :websites, :nickname, :organizations, :ims, :events
    attr_accessor :photo_href, :photo_etag

    def initialize
      @categories = []
      @email_addresses = []
      @postal_addresses = []
      @phone_numbers = []
      @websites = []
      @organizations = []
      @ims = []
      @events = []
    end

    def self.create_from_json(json)
      Contact.new.tap do |contact|
        contact.id_ = json['id'].andand['$t']
        contact.updated = json['updated'].andand['$t']
        contact.title = json['title'].andand['$t']
        contact.notes = json['content'].andand['$t']
        contact.birthday = json['gContact$birthday'].andand['when']
        contact.nickname = json["gContact$nickname"].andand['$t']

        contact.name = ContactName.create_from_json(json['gd$name'])

        json['category'].andand.each do |category|
          contact.categories.push Category.create_from_json(category)
        end

        json['gd$email'].andand.each do |email|
          contact.email_addresses.push EmailAddress.create_from_json(email)
        end

        json['link'].andand.each do |link|
          next unless link['rel'].to_s =~ /rel#photo$/

          contact.photo_href = link['href']
          contact.photo_etag = link['gd$etag']
          break
        end

        json['gd$phoneNumber'].andand.each do |phone|
          contact.phone_numbers.push PhoneNumber.create_from_json(phone)
        end

        json['gd$structuredPostalAddress'].andand.each do |addr|
          contact.postal_addresses.push PostalAddress.create_from_json(addr)
        end

        json['gContact$website'].andand.each do |website|
          contact.websites.push Website.create_from_json(website)
        end

        json['gd$organization'].andand.each do |organization|
          contact.organizations.push Organization.create_from_json(organization)
        end

        json['gd$im'].andand.each do |im|
          contact.ims.push Im.create_from_json(im)
        end

        json['gContact$event'].to_a.each do |event|
          contact.events.push Event.create_from_json(event)
        end
      end.freeze
    end
  end # class Contact
end # module GoogleContactsApiV3
