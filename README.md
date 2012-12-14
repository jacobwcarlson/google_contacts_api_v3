# Google Contacts API V3 for Ruby

**IMPORTANT**
**This code should not be considered, in any way, stable or static. It is
still very much in early development and may change drastically.**

A Rubyesque interface to the Google Contacts API (version 3). It provides
Applications access to their users' contacts, not access for individual users
to their own contacts. If that's what you're after it should be pretty
straight-forward to modify Connection::connect and just leverage the parsing
code that the rest of the library provides.

Additionally, it's read-only at this point; it doesn't have any functionality
to create/update/delete contacts.

If you've never registered an application with Google you can read more about
the process here: https://developers.google.com/console/help/#WhatIsKey

This gem assumes that you're using OAuth 1.0. This is due to the limited
support in Omniauth for OAuth 2.0. Once OAuth 2.0 is implement for the Google
service in Omniauth I'll hopefully update this thing to support 2.0 as well.

It uses the JSON interface to Google Contacts, which hopefully shouldn't
matter to you at all. If for some reason you're constrained to XML only then
unfortunately this library is not going to be useful for you :(

## Author(s)

* Jacob Carlson

## Installation

Install it manualy:

    git clone git://github.com/jacobwcarlson/google_contacts_api_v3.git
    cd google_contacts_api_v3.git 
    rake install

## Copyright

* Copyrignt (c) 2012 Jacob Carlson

See LICENSE for details. But basically you can do anything you damned please.
Credit is appreciated but not necessary.

## Example Use
    require 'GoogleContactsApiV3'
    include GoogleContactsApiV3
    connection = Connection.new(:user_token => my_users_oauth_token,
        :user_secret => my_users_oauth_secret,
        :consumer_token => my_apps_consumer_token,
        :consumer_secret => my_apps_consumer_secret)
    contacts = connection.sync_contacts
    contacts.each { |contact| p contact.inspect }

    # Only get contacts that have been updatedin the past month
    new_contacts = connection.sync_contacts(:since => (DateTime.now - 30))

## Testing
By default only "cooked" parsing tests are enabled. That is, there's a .json
file in the spec/test_data directory that contains a valid, but fake response
from the Google API. This is because we need user and consumer credentials to
actually talk to the Google Contacts API. To set this up
edit spec/test\_data/credentials.rb as follows:
    USER_AUTH_ATTRS = {
        :uid => user_id,        # e.g. user's gmail address
        :token => user_token,   # Taken from completed OAuth 1.0 grant
        :secret => user_secret, # Taken from completed OAuth 1.0 grant
    }

    CONSUMER_AUTH_ATTRS = {
        :provider => :google,       # Set to :google
        :token => consumer_token    # Name of your app registered with Google
        :secret => consumer_secret  # Provided by Google 
    }
