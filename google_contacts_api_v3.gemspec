$:.unshift(File.expand_path('../lib', __FILE__))
$:.unshift(File.expand_path('../lib/google_contacts_api_v3', __FILE__))

require 'version'

Gem::Specification.new do |s|
  s.name = 'google_contacts_api_v3'
  s.version = GoogleContactsApiV3.version
  s.homepage = 'http://github.com/jacobwcarlson/google_contacts_api_v3'
  s.email = ['the.real.jacobwcarlson@gmail.com']
  s.authors = ['Jacob W Carlson']
  s.summary = %q{A Rubyesque interface to the Google Contacts API.}
  s.description = %q{A Rubyesque interface to the Google Contacts API.}
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = %w[lib]
  s.extra_rdoc_files = %w[LICENSE README.md]

  s.add_runtime_dependency 'json', ['>= 0.1']
  s.add_runtime_dependency 'oauth2', ['>= 0.8.0']
end
