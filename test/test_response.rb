$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'

class TestResponse < MiniTest::Unit::TestCase
  def setup
    @json = TestDataLoader.test_response
  end

  def test_create_from_json
    Response.create_from_json(@json).tap do |response|
      assert_equal response.version, @json['version']
      assert_equal response.encoding, @json['encoding']
      refute_nil response.feed
      assert response.frozen?
    end
  end
end
