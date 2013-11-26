$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'

include GoogleContactsApiV3

class TestLink < MiniTest::Unit::TestCase
  def setup
    @json = TestDataLoader.test_response['feed']['link']
  end

  def test_create_from_json
    @json.each do |json_link|
      link = Link.create_from_json(json_link).tap do |link|
        assert_equal link.rel, json_link['rel']
        assert_equal link.type, json_link['type']
        assert_equal link.href, json_link['href']
      end

      assert link.frozen?
    end
  end
end
