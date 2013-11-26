$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'
require 'pry'

class TestContact < MiniTest::Unit::TestCase
  def setup
    @jsons = TestDataLoader.test_response_entries.map do |entry|
      entry['gd$name']
    end.compact
  end

  def test_create_from_json
    @jsons.each do |json|
      ContactName.create_from_json(json) do |name|
        assert_equal name.full_name, json['gd$fullName'].andand['$t']
        assert_equal name.name_prefix, json['gd$namePrefix'].andand['$t']
        assert_equal name.prefix, json['gd$namePrefix'].andand['$t']
        assert_equal name.given_name, json['gd$givenName'].andand['$t']
        assert_equal name.additional_name, json['gd$additionalName'].andand['$t']
        assert_equal name.family_name, json['gd$familyName'].andand['$t']
        assert_equal name.name_suffix, json['gd$nameSuffix'].andand['$t']
        assert_equal name.suffix, json['gd$nameSuffix'].andand['$t']

        assert name.frozen?
      end
    end
  end
end
