module GoogleContactsApiV3
  require 'util'
  include GoogleContactsApiV3::Util

  class Contact
    attr_reader :id_, :name, :updated, :categories, :title, :email_addresses
    attr_accessor :photo_href
    attr_reader :birthday, :notes, :phone_numbers, :postal_addresses
    attr_reader :websites

    def initialize(args)
      @id_ = args[:id_]
      @updated = args[:updated]
      @title = args[:title]
      @notes = args[:notes]
      @birthday = args[:birthday]
      @name = args[:name]
      @categories = args[:categories]
      @email_addresses = args[:email_addresses]
      @photo_href = args[:photo_href]
      @phone_numbers = args[:phone_numbers]
      @postal_addresses = args[:postal_addresses]
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

    def self.create_from_json(json_map)
      return nil unless json_map

      contact = Contact.new(:id => Util.get_hash_val(json_map, 'id'),
        :updated => Util.get_hash_val(json_map, 'updated'),
        :title => Util.get_hash_val(json_map, 'title'),
        :notes => Util.get_hash_val(json_map, 'content'),
        :birthday => Util.get_hash_val(json_map, 'gContact$birthday', 'when'),
        :name => ContactName.create_from_json(json_map['gd$name']))

      json_map['category'].to_a.each do |category|
        contact.add_category(Category.create_from_json category)
      end

      json_map['gd$email'].to_a.each do |email|
        contact.add_email_address(EmailAddress.create_from_json email)
      end

      json_map['link'].to_a.each do |link|
        if link['rel'].to_s =~ /rel#photo$/
          contact.photo_href = link['href']
          break
        end
      end

      json_map['gd$phoneNumber'].to_a.each do |phone|
        contact.add_phone_number phone['$t']
      end

      json_map['gd$structuredPostalAddress'].to_a.each do |addr|
        contact.add_postal_address(PostalAddress.create_from_json addr)
      end

      json_map['gContact$website'].to_a.each do |website|
        contact.add_website(Website.create_from_json website)
      end

      contact
    end
  end # class Contact
end # module GoogleContactsApiV3
