$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'spec_helper'
require 'google_contacts_api_v3'

describe GoogleContactsApiV3 do
  before :all do
    fname = File.dirname(__FILE__) + "/test_data/fake_response.json"
    @fake_json_response = JSON.parse File.read(fname)
  end

  it "should have the correct response-level values" do
    response = GoogleContactsApiV3::Response.create_from_json @fake_json_response
    response.should_not be_nil

    response.version.should eq "1.0"
    response.encoding.should eq "UTF-8"
  end

  it "should have the correct feed-level values" do
    response = GoogleContactsApiV3::Response.create_from_json @fake_json_response
    feed = response.feed
    feed.should_not be_nil

    feed.namespaces.should include "http://www.w3.org/2005/Atom"
    feed.namespaces.should include "http://a9.com/-/spec/opensearch/1.1/"
    feed.namespaces.should include "http://schemas.google.com/contact/2008"
    feed.namespaces.should include "http://schemas.google.com/gdata/batch"
    feed.namespaces.should include "http://schemas.google.com/g/2005"

    feed.id_.should eq "sometestaccount@gmail.com"
    feed.updated.should eq "2012-08-08T16:56:55.874Z"
    feed.title.should eq "Test Contact Account's Contacts"
    feed.total_results.should eq "1"
    feed.start_index.should eq "1"
    feed.items_per_page.should eq "25"

    feed.categories.size.should eq 1
    feed.categories.first.scheme.should eq "http://schemas.google.com/g/2005#kind"
    feed.categories.first.term.should eq "http://schemas.google.com/contact/2008#contact"

    feed.links.size.should eq 6
    feed.links[0].rel.should eq "alternate"
    feed.links[0].type.should eq "text/html"
    feed.links[0].href.should eq "http://www.google.com/"
    feed.links[1].rel.should eq "http://schemas.google.com/g/2005#feed"
    feed.links[1].type.should eq "application/atom+xml"
    feed.links[1].href.should eq "https://www.google.com/m8/feeds/contacts/sometestaccount%40gmail.com/full"
    feed.links[2].rel.should eq "http://schemas.google.com/g/2005#post"
    feed.links[2].type.should eq "application/atom+xml"
    feed.links[2].href.should eq "https://www.google.com/m8/feeds/contacts/sometestaccount%40gmail.com/full"
    feed.links[3].rel.should eq "http://schemas.google.com/g/2005#batch"
    feed.links[3].type.should eq "application/atom+xml"
    feed.links[3].href.should eq "https://www.google.com/m8/feeds/contacts/sometestaccount%40gmail.com/full/batch"
    feed.links[4].rel.should eq "self"
    feed.links[4].type.should eq "application/atom+xml"
    feed.links[4].href.should eq "https://www.google.com/m8/feeds/contacts/sometestaccount%40gmail.com/full?alt\u003djson\u0026max-results\u003d25"
    feed.links[5].rel.should eq "next"
    feed.links[5].type.should eq "application/atom+xml"
    feed.links[5].href.should eq "https://www.google.com/m8/feeds/contacts/sometestaccount%40gmail.com/full?alt\u003djson\u0026start-index\u003d26\u0026max-results\u003d25"

    feed.authors.size.should eq 1
    feed.authors.first.name.should eq "Test Contact Account"
    feed.authors.first.email.should eq "sometestaccount@gmail.com"
  end

  it "should have correct contact details" do
    pending "Just need to stop being lazy."
  end
end
