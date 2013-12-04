module GoogleContactsApiV3
  require 'util'

  class Feed
    attr_accessor :namespaces, :id_, :updated, :categories, :title, :links
    attr_accessor :authors, :total_results, :start_index, :items_per_page
    attr_accessor :entries

    def self.create_from_json(json)
      return nil unless json

      Feed.new.tap do |feed|
        feed.id_ = json.andand['id']['$t']
        feed.updated = DateTime.parse(json.andand['updated']['$t'])
        feed.title = json.andand['title']['$t']
        feed.total_results = json.andand['openSearch$totalResults']['$t'].to_i
        feed.start_index = json.andand['openSearch$startIndex']['$t'].to_i
        feed.items_per_page = json.andand['openSearch$itemsPerPage']['$t'].to_i

        feed.add_namespace json['xmlns']
        feed.add_namespace json['xmlns$openSearch']
        feed.add_namespace json['xmlns$gContact']
        feed.add_namespace json['xmlns$batch']
        feed.add_namespace json['xmlns$gd']

        json['category'].andand.each do |category|
          feed.add_category Category.create_from_json(category)
        end

        json['author'].andand.each do |author|
          feed.add_author Author.create_from_json(author)
        end

        json['link'].andand.each do |link|
          feed.add_link Link.create_from_json(link)
        end

        json['entry'].andand.each do |entry|
          feed.add_contact Contact.create_from_json(entry)
        end
      end.freeze 
    end

    def add_namespace(namespace)
      namespace.andand.tap do |namespace|
        @namespaces ||= []
        @namespaces.push namespace
      end
    end

    def add_category(category)
      category.andand.tap do |category|
        @categories ||= []
        @categories.push category
      end
    end

    def add_author(author)
      author.andand.tap do |author|
        @authors ||= []
        @authors.push author
      end
    end

    def add_link(link)
      link.andand.tap do |link|
        @links ||= []
        @links.push link
      end
    end

    def add_entry(entry)
      entry.andand.tap do |entry|
        @entries ||= []
        @entries.push entry
      end
    end

    def add_contact(contact)
      add_entry contact
    end

    def contacts
      @entries
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
