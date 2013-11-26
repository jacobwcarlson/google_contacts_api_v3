$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'
require 'pry'

class TestContact < MiniTest::Unit::TestCase
  def setup
    @jsons= TestDataLoader.test_response_entries.map do |entry|
      entry['gd$phoneNumber']
    end.compact.flatten
  end

  def test_create_from_json
    @jsons.each do |json|
      PhoneNumber.create_from_json(json).tap do |phone|
        assert_equal phone.rel, json['rel']
        assert_equal phone.type, json['rel'].to_s.split("#").last
        assert_equal phone.uri, json['uri']
        assert_equal phone.as_text, json['$t']
        assert_equal phone.primary, json['primary'] == "true"

        assert phone.frozen?
      end
    end
  end
end
