# -*- ruby -*-
$:.unshift(File.expand_path('../lib', __FILE__))
require 'rake/testtask'
require 'google_contacts_api_v3/version'

begin 
  require 'json'
rescue LoadError
  STDERR.puts e.message
  STDERR.puts "Run `gem install json` to install JSON"
end

begin 
  require 'oauth2'
rescue LoadError
  STDERR.puts "Run `gem install oauth2` to install oauth2"
end


Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test_*.rb']
  t.verbose = true
end
