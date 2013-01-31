module GoogleContactsApiV3
  class UnsupportedOAuthVersion < StandardError ; end

  class Connection
    DEFAULT_JSON_CONTACTS_PATH = "/m8/feeds/contacts/default/full?alt=json&v=3"

    attr_reader :message

    def initialize(args)
      @access_token = args[:access_token]
      @client_id = args[:client_id]
      @client_secret = args[:client_secret]
    end

    def ping
      connect
      resp = @connection.get DEFAULT_JSON_CONTACTS_PATH
      return(resp.status == 200 || resp.status == 201)
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
        resp = @connection.get path
        return contacts unless [200, 201].include? resp.status
        @message = Response.create_from_json(JSON.parse resp.body)
        contacts += @message.feed.contacts.to_a
        path = @message.feed.next_url
      end

      contacts
    end

  private
    def connect
      return @connection unless @connection.nil?

      opts = {
        :site => "https://www.google.com",
        :scheme => :header,
        :http_method => :post
      }

      client = OAuth2::Client.new(@client_id, @client_secret, opts)
      @connection = OAuth2::AccessToken.new(client, @access_token)
    end
  end # class Connection
end # GoogleContactsApiV3
