module GoogleContactsApiV3
  require 'util'
  include GoogleContactsApiV3::Util

  class Contact
    attr_reader :id_, :name, :updated, :categories, :title, :email_addresses
    attr_reader :birthday, :notes, :phone_numbers, :postal_addresses
    attr_reader :websites, :nickname, :organizations, :ims, :events
    attr_accessor :photo

    def initialize(args)
      @birthday = args[:birthday]
      @categories = args[:categories]
      @email_addresses = args[:email_addresses]
      @events = args[:events]
      @id_ = args[:id_]
      @name = args[:name]
      @nickname = args[:nickname]
      @notes = args[:notes]
      @organization = args[:organization]
      @phone_numbers = args[:phone_numbers]
      @photo = args[:photo]
      @postal_addresses = args[:postal_addresses]
      @title = args[:title]
      @updated = args[:updated]
      @websites = args[:websites]
    end

    def add_category(category)
      return false unless category
      @categories ||= []
      @categories.push category

      true
    end

    def add_email_address(addr)
      return false unless addr
      @email_addresses ||= []
      @email_addresses.push addr

      true
    end

    def add_postal_address(addr)
      return false unless addr
      @postal_addresses ||= []
      @postal_addresses.push addr

      true
    end

    def add_phone_number(phone)
      return false unless phone
      @phone_numbers ||= []
      @phone_numbers.push phone

      true
    end

    def add_website(website)
      return false unless website
      @websites ||= []
      @websites.push website

      true
    end

    def add_organization(organization)
      return false unless organization
      @organizations ||= []
      @organizations.push organization

      true
    end

    def add_im(im)
      return false unless im
      @ims ||= []
      @ims.push im

      true
    end

    def add_event(event)
      return false unless event
      @events ||= []
      @events.push event

      true
    end

    def add_photo(photo)
      @photo = photo

      true
    end

    def self.create_from_json(json_map)
      return nil unless json_map

      contact = Contact.new(:id => Util.get_text_val(json_map, 'id'),
        :updated => Util.get_text_val(json_map, 'updated'),
        :title => Util.get_text_val(json_map, 'title'),
        :notes => Util.get_text_val(json_map, 'content'),
        :birthday => Util.get_text_val(json_map, 'gContact$birthday', 'when'),
        :nickname => Util.get_text_val(json_map, "gContact$nickname"),
        :name => ContactName.create_from_json(json_map['gd$name']))

      json_map['category'].to_a.each do |category|
        contact.add_category(Category.create_from_json category)
      end

      json_map['gd$email'].to_a.each do |email|
        contact.add_email_address(EmailAddress.create_from_json email)
      end

      json_map['link'].to_a.each do |link|
        if link['rel'].to_s =~ /rel#photo$/
          contact.add_photo(Photo.create_from_json(link))
          break
        end
      end

      json_map['gd$phoneNumber'].to_a.each do |phone|
        contact.add_phone_number(PhoneNumber.create_from_json phone)
      end

      json_map['gd$structuredPostalAddress'].to_a.each do |addr|
        contact.add_postal_address(PostalAddress.create_from_json addr)
      end

      json_map['gContact$website'].to_a.each do |website|
        contact.add_website(Website.create_from_json website)
      end

      json_map['gd$organization'].to_a.each do |organization|
        contact.add_organization(Organization.create_from_json organization)
      end

      json_map['gd$im'].to_a.each do |im|
        contact.add_im(Im.create_from_json im)
      end

      json_map['gContact$event'].to_a.each do |event|
        contact.add_event(Event.create_from_json event)
      end

      contact
    end
  end # class Contact
end # module GoogleContactsApiV3
