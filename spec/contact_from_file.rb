$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'spec_helper'
require 'google_contacts_api_v3'

describe GoogleContactsApiV3 do
  before :all do
    fname = File.dirname(__FILE__) + "/test_data/fake_response.json"
    @cooked_json = JSON.parse File.read(fname)
  end

  it "should have the correct response-level values" do
    response = GoogleContactsApiV3::Response.create_from_json @cooked_json
    response.should_not be_nil

    response.version.should eq "1.0"
    response.encoding.should eq "UTF-8"
  end

  it "should have the correct feed-level values" do
    response = GoogleContactsApiV3::Response.create_from_json @cooked_json
    feed = response.feed
    feed.should_not be_nil

    feed.namespaces.should include "http://www.w3.org/2005/Atom"
    feed.namespaces.should include "http://a9.com/-/spec/opensearch/1.1/"
    feed.namespaces.should include "http://schemas.google.com/contact/2008"
    feed.namespaces.should include "http://schemas.google.com/gdata/batch"
    feed.namespaces.should include "http://schemas.google.com/g/2005"

    feed.id_.should eq "http://www.google.com/m8/feeds/contacts/sometestaccount%40gmail.com/base/1be9aefa0b5e5024"
    
    feed.updated.should eq "2012-08-17T18:26:58.992Z"
    feed.title.should eq "Test Contact Feed"
    feed.total_results.should eq "1"
    feed.start_index.should eq "1"
    feed.items_per_page.should eq "25"

    feed.categories.size.should eq 1
    feed.categories.first.scheme.should eq "http://schemas.google.com/g/2005#kind"
    feed.categories.first.term.should eq "http://schemas.google.com/contact/2008#contact"

    feed.links.size.should eq 4
    feed.links[0].rel.should eq "http://schemas.google.com/contacts/2008/rel#photo"
    feed.links[0].type.should eq "image/*"
    feed.links[0].href.should eq "https://www.google.com/m8/feeds/photos/media/sometestaccount%40gmail.com/1be9aefa0b5e5024?v=3"
    
    feed.links[1].rel.should eq "self"
    feed.links[1].type.should eq "application/atom+xml"
    feed.links[1].href.should eq "https://www.google.com/m8/feeds/contacts/sometestaccount%40gmail.com/full/1be9aefa0b5e5024?v=3"

    feed.links[2].rel.should eq "edit"
    feed.links[2].type.should eq "application/atom+xml"
    feed.links[2].href.should eq "https://www.google.com/m8/feeds/contacts/sometestaccount%40gmail.com/full/1be9aefa0b5e5024?v=3"
  end

  it "should have correct contact details" do
    response = GoogleContactsApiV3::Response.create_from_json @cooked_json
    test_contact = response.feed.contacts.first

    test_contact.title.should eq "Dr. Test W. Contact Esq."
    test_contact.notes.should eq "Notes about this test contact."
    test_contact.birthday.should eq "1974-01-01"

    test_contact.name.full_name.should eq "Dr. Test W. Contact Esq."
    test_contact.name.name_prefix.should eq "Dr."
    test_contact.name.prefix.should eq "Dr."
    test_contact.name.given_name.should eq "Test"
    test_contact.name.additional_name.should eq "W"
    test_contact.name.family_name.should eq "Contact"
    test_contact.name.name_suffix.should eq "Esq."
    test_contact.name.suffix.should eq "Esq."
    test_contact.nickname.should eq "Testy"

    test_contact.photo_href.should eq "https://www.google.com/m8/feeds/photos/media/sometestaccount%40gmail.com/1be9aefa0b5e5024?v\u003d3"

    test_contact.organizations[0].type.should eq "other"
    test_contact.organizations[0].org_name.should eq "Testing, Inc."
    test_contact.organizations[0].name.should eq "Testing, Inc."
    test_contact.organizations[0].org_title.should eq "Sr. Contact Manager"
    test_contact.organizations[0].title.should eq "Sr. Contact Manager"

    test_contact.email_addresses[0].address.should eq "test@example.com"
    test_contact.email_addresses[0].primary.should be_true
    test_contact.email_addresses[0].type.should eq "home"
    test_contact.email_addresses[0].rel.should eq "home"
    test_contact.email_addresses[0].label.should eq "home"

    test_contact.email_addresses[1].address.should eq "test@work.example.com"
    test_contact.email_addresses[1].primary.should be_false
    test_contact.email_addresses[1].type.should eq "work"
    test_contact.email_addresses[1].rel.should eq "work"
    test_contact.email_addresses[1].label.should eq "work"

    test_contact.email_addresses[2].address.should eq "test@play.example.com"
    test_contact.email_addresses[2].primary.should be_false
    test_contact.email_addresses[2].label.should eq "Play"

    test_contact.ims[0].address.should eq "testcontact.gtalk"
    test_contact.ims[0].protocol.should eq "GOOGLE_TALK"
    test_contact.ims[0].rel.should eq "other"
    test_contact.ims[1].address.should eq "testcontact.aim"
    test_contact.ims[1].protocol.should eq "AIM"
    test_contact.ims[1].rel.should eq "other"
    test_contact.ims[2].address.should eq "testcontact.yahoo"
    test_contact.ims[2].protocol.should eq "YAHOO"
    test_contact.ims[2].rel.should eq "other"
    test_contact.ims[3].address.should eq "testcontact.skype"
    test_contact.ims[3].protocol.should eq "SKYPE"
    test_contact.ims[3].rel.should eq "other"
    test_contact.ims[4].address.should eq "testcontact.whatisqq"
    test_contact.ims[4].protocol.should eq "QQ"
    test_contact.ims[4].rel.should eq "other"
    test_contact.ims[5].address.should eq "testcontact.msn"
    test_contact.ims[5].protocol.should eq "MSN"
    test_contact.ims[5].rel.should eq "other"
    test_contact.ims[6].address.should eq "testcontact.icq"
    test_contact.ims[6].protocol.should eq "ICQ"
    test_contact.ims[6].rel.should eq "other"
    test_contact.ims[7].address.should eq "testcontact.jabber"
    test_contact.ims[7].protocol.should eq "JABBER"
    test_contact.ims[7].rel.should eq "other"
    test_contact.ims[8].address.should eq "testcontact.custom_im_service"
    test_contact.ims[8].protocol.should eq "Custom IM Service"
    test_contact.ims[8].rel.should eq "other"
    
    test_contact.phone_numbers[0].rel.should eq "mobile"
    test_contact.phone_numbers[0].as_text.should eq "212-555-1212"

    test_contact.phone_numbers[1].rel.should eq "work"
    test_contact.phone_numbers[1].as_text.should eq "212-555-2323"

    test_contact.phone_numbers[2].rel.should eq "home"
    test_contact.phone_numbers[2].as_text.should eq "212-555-3434"

    test_contact.phone_numbers[3].rel.should eq "main"
    test_contact.phone_numbers[3].as_text.should eq "212-555-4545"

    test_contact.phone_numbers[4].rel.should eq "work_fax"
    test_contact.phone_numbers[4].as_text.should eq "212-555-5656"

    test_contact.phone_numbers[5].rel.should eq "home_fax"
    test_contact.phone_numbers[5].as_text.should eq "212-555-6767"

    test_contact.phone_numbers[6].label.should eq "grandcentral"
    test_contact.phone_numbers[6].as_text.should eq "212-555-7878"

    test_contact.phone_numbers[7].rel.should eq "pager"
    test_contact.phone_numbers[7].as_text.should eq "212-555-8989"
      
    test_contact.phone_numbers[8].label.should eq "Satellite Phone"
    test_contact.phone_numbers[8].as_text.should eq "212-555-9090"
    
    test_contact.postal_addresses[0].rel.should eq "home"
    test_contact.postal_addresses[0].formatted_address.should eq "1 Penn Plaza\nNew York, New York 10019\nU.S.A."
    test_contact.postal_addresses[0].street.should eq "1 Penn Plaza"
    test_contact.postal_addresses[0].post_code.should eq "10019"
    test_contact.postal_addresses[0].city.should eq "New York"
    test_contact.postal_addresses[0].region.should eq "New York"
    test_contact.postal_addresses[0].country.should eq "US"

    test_contact.postal_addresses[1].rel.should eq "work"
    test_contact.postal_addresses[1].formatted_address.should eq "2 Penn Plaza\nNew York, New York 10019\nUS"
    test_contact.postal_addresses[1].street.should eq "2 Penn Plaza"
    test_contact.postal_addresses[1].post_code.should eq "10019"
    test_contact.postal_addresses[1].city.should eq "New York"
    test_contact.postal_addresses[1].region.should eq "New York"
    test_contact.postal_addresses[1].country.should eq "US"

    test_contact.postal_addresses[2].rel.should eq "other"
    test_contact.postal_addresses[2].formatted_address.should eq "400 16th St.\n31337\nBrooklyn, New York 11215\nU.S.A."
    test_contact.postal_addresses[2].street.should eq "400 16th St."
    test_contact.postal_addresses[2].pobox.should eq "31337"
    test_contact.postal_addresses[2].post_code.should eq "11215"
    test_contact.postal_addresses[2].city.should eq "Brooklyn"
    test_contact.postal_addresses[2].region.should eq "New York"
    test_contact.postal_addresses[2].country.should eq "US"

    test_contact.events[0].rel.should eq "anniversary"
    test_contact.events[0].label.should eq "anniversary"
    test_contact.events[0].when.should eq DateTime.parse("2000-06-01")

    test_contact.events[1].label.should eq "Hire Date"
    test_contact.events[1].when .should eq DateTime.parse("1999-08-01")

    test_contact.websites[0].href.should eq "about.me/SomeTestContact"
    test_contact.websites[0].rel.should eq "profile"
    test_contact.websites[1].href.should eq "blog.example.com/SomeTestContact"
    test_contact.websites[1].rel.should eq "blog"
    test_contact.websites[2].href.should eq "homepage.example.com/~SomeTestContact"
    test_contact.websites[2].rel.should eq "home-page"
    test_contact.websites[3].href.should eq "work.example.com"
    test_contact.websites[3].rel.should eq "work"
    test_contact.websites[4].href.should eq "SomeTestContact.tumblr.com"
    test_contact.websites[4].label.should eq "Tumblr"
  end
end
