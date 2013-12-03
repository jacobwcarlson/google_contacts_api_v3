$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'
require 'pry'

class TestOrganization < MiniTest::Unit::TestCase
  def setup
    @jsons= TestDataLoader.test_response_entries.map do |entry|
      entry['gd$organization']
    end.compact.flatten
  end

  def test_create_from_json
    @jsons.each do |json|
      Organization.create_from_json(json).tap do |org|
        assert_equal org.rel, json['rel']
        assert_equal org.type, json['rel'].to_s.split("#").last
        assert_equal org.org_name, json['gd$orgName'].andand['$t']
        assert_equal org.org_title, json['gd$orgTitle'].andand['$t']
        assert_equal org.org_department,
          json['gd$orgDepartment'].andand['$t']
        assert_equal org.org_job_description,
          json['gd$orgJobDescription'].andand['$t']
        assert_equal org.org_symbol, json['gd$orgSymbol'].andand['$t']
        assert_equal org.where, json['gd$where'].andand['$t']

        assert org.frozen?
      end
    end
  end
end
