module GoogleContactsApiV3
  class Version #:nodoc:
    MAJOR  = 0
    MINOR  = 3
    PATCH  = 1
    STRING = [MAJOR, MINOR, PATCH].join('.')
  end # Version
  
  def self.version # :nodoc:
    Version::STRING
  end 
end # GoogleContactsApiV3
