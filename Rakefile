# -*- ruby -*-

$:.unshift(File.expand_path('../lib', __FILE__))
require 'google_contacts_api_v3/version'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  task :spec do
    abort 'Run `gem install rspec` to install RSpec'
  end
end

task :test => :spec
task :default => :test

begin 
  require 'json'
rescue LoadError
  STDERR.puts e.message
  STDERR.puts "Run `gem install json` to install JSON"
end

begin 
  require 'oauth'
rescue LoadError
  STDERR.puts e.message
  STDERR.puts "Run `gem install oauth` to install oauth"
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Google Contacts Parser for Ruby #{GoogleContactsApiV3.version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
