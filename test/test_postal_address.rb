$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'
require 'pry'

class TestPostalAddress < MiniTest::Unit::TestCase
  def setup
    @jsons= TestDataLoader.test_response_entries.map do |entry|
      entry['gd$phoneNumber']
    end.compact.flatten
  end

  def test_create_from_json
    @jsons.each do |json|
      PostalAddress.create_from_json(json).tap do |address|
        assert_equal address.rel, json['rel']
        assert_equal address.label, json['label']
        assert_equal address.usage, json['usage']
        assert_equal address.mail_class, json['mailClass']
        assert_equal address.primary, json['primary'] == "true"

        assert_equal address.city, json['gd$city'].andand['$t']
        assert_equal address.country, json['gd$country'].andand['$t']
        assert_equal address.formatted_address,
          json['gd$formattedAddress'].andand['$t']
        assert_equal address.post_code, json['gd$postcode'].andand['$t']
        assert_equal address.region, json['gd$region'].andand['$t']
        assert_equal address.street, json['gd$street'].andand['$t']
        assert_equal address.housename, json['gd$housename']
        assert_equal address.neighborhood, json['gd$neighborhhood']
        assert_equal address.subregion, json['gd$subregion']

        assert address.frozen?
      end
    end
  end
end
