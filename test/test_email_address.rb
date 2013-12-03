$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'
require 'pry'

class TestEmailAddress < MiniTest::Unit::TestCase
  def setup
    @jsons= TestDataLoader.test_response_entries.map do |entry|
      entry['gd$email']
    end.compact.flatten
  end

  def test_create_from_json
    @jsons.each do |json|
      EmailAddress.create_from_json(json).tap do |email|
        assert_equal email.address, json['address']
        assert_equal email.primary, (json['primary'] == "true")
        assert_equal email.rel, json['rel']
        assert_equal email.type, json['rel'].to_s.split("#").last
        assert_equal email.label, json['label']

        assert email.frozen?
      end
    end
  end
end
