module GoogleContactsApiV3
  require 'util'

  class Feed
    attr_reader :namespaces, :id_, :updated, :categories, :title, :links
    attr_reader :authors, :total_results, :start_index, :items_per_page
    attr_reader :entries

    def initialize(args = {})
      @id_ = args[:id_]
      @updated = args[:updated]
      @title = args[:title]
      @total_results = args[:total_results]
      @start_index = args[:start_index]
      @items_per_page = args[:items_per_page]
      @namespaces = args[:namespaces]
      @categories = args[:categories]
      @authors = args[:authors]
      @links = args[:links]
      @entries = args[:entries]
    end

    def self.create_from_json(json_map)
      feed = Feed.new(:id_ => Util.get_hash_val(json_map, 'id'),
        :updated => Util.get_hash_val(json_map, 'updated'),
        :title => Util.get_hash_val(json_map, 'title'),
        :total_results => Util.get_hash_val(json_map,
          'openSearch$totalResults'),
        :start_index => Util.get_hash_val(json_map, 'openSearch$startIndex'),
        :items_per_page => Util.get_hash_val(json_map,
          'openSearch$itemsPerPage'))

      feed.add_namespace json_map['xmlns']
      feed.add_namespace json_map['xmlns$openSearch']
      feed.add_namespace json_map['xmlns$gContact']
      feed.add_namespace json_map['xmlns$batch']
      feed.add_namespace json_map['xmlns$gd']

      json_map['category'].to_a.each do |category|
        feed.add_category(Category.create_from_json category)
      end

      json_map['author'].to_a.each do |author|
        feed.add_author(Author.create_from_json author)
      end

      json_map['link'].to_a.each do |link|
        feed.add_link(Link.create_from_json link)
      end

      json_map['entry'].to_a.each do |entry|
        feed.add_contact(Contact.create_from_json entry)
      end

      feed
    end

    def add_namespace(namespace)
      @namespaces ||= []
      return false unless namespace
      @namespaces.push namespace

      true
    end

    def add_category(category)
      return false unless category
      @categories ||= []
      @categories.push category

      true
    end

    def add_author(author)
      return false unless author
      @authors ||= []
      @authors.push author

      true
    end

    def add_link(link)
      return false unless link
      @links ||= []
      @links.push link

      true
    end

    def add_contact(contact)
      return false unless contact
      @contacts ||= []
      @contacts.push contact

      true
    end

    def next_url
      @links.to_a.each do |link|
        next unless link.rel == "next"
        return link.href
      end

      nil
    end
  end # class Feed
end # module GoogleContactsApiV3
