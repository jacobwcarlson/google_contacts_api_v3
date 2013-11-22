require 'json'

class TestDataLoader
  TEST_DATA_DIR = File.dirname(__FILE__) + "/test_data"

  def self.[](fname)
    @@test_data ||= {}
    @@test_data[fname] ||= JSON.parse(File.read("#{TEST_DATA_DIR}/#{fname}"))
  end
end
