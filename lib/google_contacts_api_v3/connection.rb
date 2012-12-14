module GoogleContactsApiV3
  class Connection
    DEFAULT_JSON_CONTACTS_PATH = "/m8/feeds/contacts/default/full?alt=json&v=3"

    attr_reader :message

    def initialize(args)
      @user_token = args[:user_token]
      @user_secret = args[:user_secret]
      @consumer_token = args[:consumer_token]
      @consumer_secret = args[:consumer_secret]

      true
    end

    def ping
      connect
      resp = @connection.get DEFAULT_JSON_CONTACTS_PATH
      return(resp.code.to_i == 200 || resp.code.to_i == 201)
    end

    # Retrieve all contacts from the user's Google account. If args[:since]
    # is not nil (and is a valid DateTime object) it will only return contacts
    # modified since that time.
    def get_contacts(args = {})
      path = DEFAULT_JSON_CONTACTS_PATH
      if args[:since]
        updated_min = "%d-%02d-%02dT%02d:%02d:%02d" % [args[:since].year,
          args[:since].month, args[:since].day, args[:since].hour,
          args[:since].min, args[:since].sec ]
        path += "&updated-min=#{updated_min}"
      end

      path += "&max-results=1000"
      connect
      contacts = []
      while 1
        break unless path
        resp = @connection.get(path)
        return contacts unless [200, 201].include? resp.code.to_i
        @message = Response.create_from_json(JSON.parse resp.body)
        contacts += @message.feed.contacts.to_a
        path = @message.feed.next_url
      end

      contacts
    end

    def get_photo_data(photo, unless_etag = nil)
      return photo unless photo.etag
      return photo unless_tag != photo.etag

      resp = @connection.get(photo.href)
      if [200, 201].include? resp.code.to_i
        photo.data = resp.body
        photo.content_type = resp['Content-Type']
        photo.etag = resp['etag']
      end

      photo
    end

  private
    def connect
      return @connection unless @connection.nil?

      opts = {
        :site => "https://www.google.com",
        :scheme => :header,
        :http_method => :post
      }

      consumer = OAuth::Consumer.new(@consumer_token, @consumer_secret, opts)
      @connection = OAuth::AccessToken.new(consumer, @user_token, @user_secret)
    end
  end # class Connection
end # GoogleContactsApiV3
