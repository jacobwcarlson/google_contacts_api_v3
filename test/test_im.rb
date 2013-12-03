$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'
require 'pry'

class TestIm < MiniTest::Unit::TestCase
  def setup
    @jsons = TestDataLoader.test_response_entries.map do |entry|
      entry['gd$im']
    end.compact.flatten
  end

  def test_create_from_json
    @jsons.each do |json|
      Im.create_from_json(json).tap do |im|
        assert_equal im.address, json['address']
        assert_equal im.protocol, json['protocol'].to_s.split("#").last
        assert_equal im.rel, json['rel']
        assert_equal im.type, json['rel'].to_s.split("#").last

        assert im.frozen?
      end
    end
  end
end
