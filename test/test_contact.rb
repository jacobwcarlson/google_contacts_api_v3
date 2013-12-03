$LOAD_PATH.push File.dirname __FILE__

require 'minitest/autorun'
require 'support/support'
require 'pry'

class TestContact < MiniTest::Unit::TestCase
  def setup
    @json = TestDataLoader.test_response['feed']['entry']
  end

  def test_create_from_json
    @json.each do |json_contact|
      contact = Contact.create_from_json(json_contact).tap do |contact|
        assert_equal contact.title, json_contact['title'].andand['$t']
        assert_equal contact.notes, json_contact['content'].andand['$t']
        assert_equal contact.birthday,
          json_contact['gContact$birthday'].andand['when']
        assert_equal contact.nickname,
          json_contact['gContact$nickname'].andand['$t']

        assert_equal contact.organizations.size,
          json_contact['gd$organization'].size
        assert_equal contact.email_addresses.size,
          json_contact['gd$email'].size
        assert_equal contact.phone_numbers.size,
          json_contact['gd$phoneNumber'].size
        assert_equal contact.postal_addresses.size,
          json_contact['gd$structuredPostalAddress'].size

        json_contact['gContact$event'].each_with_index do |gd_event, idx|
          contact.events[idx].tap do |event|
            assert_equal event.rel, gd_event['rel']
            assert_equal event.label, gd_event['label']
            assert_equal event.when,
              DateTime.parse(gd_event['gd$when']['startTime'])

            assert event.frozen?
          end
        end

        json_contact['gContact$website'].each_with_index do |gd_site, idx|
          contact.websites[idx].tap do |website|
            assert_equal website.href, gd_site['href']
            assert_equal website.rel, gd_site['rel']
            assert_equal website.label, gd_site['label']

            assert website.frozen?
          end
        end

        assert contact.frozen?
      end
    end
  end
end
