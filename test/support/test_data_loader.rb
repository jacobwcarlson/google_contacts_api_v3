require 'json'

class TestDataLoader
  TEST_DATA_DIR = File.dirname(__FILE__) + "/test_data"

  def self.[](fname)
    @@test_data ||= {}
    @@test_data[fname] ||= JSON.parse(File.read("#{TEST_DATA_DIR}/#{fname}"))
  end

  def self.test_response
    self['fake_response.json']
  end

  def self.test_response_entries
    self.test_response['feed']['entry']
  end
end
