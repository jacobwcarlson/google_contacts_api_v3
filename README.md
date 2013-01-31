# Google Contacts API V3 for Ruby

**IMPORTANT**
**This code should not be considered, in any way, stable or static. It is
still very much in early development and may change drastically. As proof of
that see the 'ALSO IMPORTANT' section below as an example of how I just up and
changed shit.**

A Rubyesque interface to the Google Contacts API (version 3). It provides
Applications access to their users' contacts, not access for individual users
to their own contacts. If that's what you're after it should be pretty
straight-forward to modify Connection::connect and just leverage the parsing
code that the rest of the library provides.

Additionally, it's read-only at this point; it doesn't have any functionality
to create/update/delete contacts.

If you've never registered an application with Google you can read more about
the process here: https://developers.google.com/console/help/#WhatIsKey

**ALSO IMPORTANT**
As of version 0.2.0 this gem now only supports OAuth 2.0 (see what I did
there? Yah, that's just coincidence). The args supplied to Connection#new have
been changed to reflect that, see below. Since OAuth 1.0 support within
Google is now deprecated there was no sense in making this work with both,
considering how different the oauth and oauth2 gems are. If you need support
for OAuth 1.0 you can use any 0.1.4 of this gem. It's not like anyone but
me uses this thing anyway :(.

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

* Copyrignt (c) 2012,2013 Jacob Carlson

See LICENSE for details. But basically you can do anything you damned please.
Credit is appreciated but not necessary.

## Example Use
    require 'GoogleContactsApiV3'
    include GoogleContactsApiV3

    connection = Connection.new(:access_token => my_users_oauth2_token,
        :consumer_token => my_apps_consumer_token,
        :consumer_secret => my_apps_consumer_secret)
    contacts = connection.get_contacts
    contacts.each{ |contact| p contact.inspect }

    # Only get contacts that have been updatedin the past month
    new_contacts = connection.get_contacts(:since => (DateTime.now - 30))

## Testing
By default only "cooked" parsing tests are enabled. That is, there's a .json
file in the spec/test_data directory that contains a valid, but fake response
from the Google API.
