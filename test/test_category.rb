$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'

include GoogleContactsApiV3

class TestFeed < MiniTest::Unit::TestCase
  def setup
    @json = TestDataLoader.test_response['feed']['category']
  end


  def test_create_from_json
    @json.each do |json_category|
      category = Category.create_from_json(json_category).tap do |category|
        assert_equal category.scheme, json_category['scheme']
        assert_equal category.term, json_category['term']
      end

      assert category.frozen?
    end
  end
end
