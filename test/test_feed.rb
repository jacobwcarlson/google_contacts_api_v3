$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'
require 'pry'

class TestFeed < MiniTest::Unit::TestCase
  def setup
    @json = TestDataLoader.test_response['feed']
  end

  def test_create_from_json
    GoogleContactsApiV3::Feed.create_from_json(@json).tap do |feed|
      assert_equal feed.id_, @json['id']['$t']
      assert_equal feed.updated, DateTime.parse(@json['updated']['$t'])
      assert_equal feed.title, @json['title']['$t']
      assert_equal feed.total_results, @json['openSearch$totalResults']['$t'].to_i
      assert_equal feed.start_index, @json['openSearch$startIndex']['$t'].to_i
      assert_equal feed.items_per_page, @json['openSearch$itemsPerPage']['$t'].to_i

      assert_equal feed.categories.size, @json['category'].size
      assert_equal feed.links.size, @json['link'].size
      assert feed.frozen?
    end
  end
end
