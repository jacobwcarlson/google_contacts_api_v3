module GoogleContactsApiV3
  class Version #:nodoc:
    MAJOR  = 0
    MINOR  = 2
    PATCH  = 0
    STRING = [MAJOR, MINOR, PATCH].join('.')
  end # Version
  
  def self.version # :nodoc:
    Version::STRING
  end 
end # GoogleContactsApiV3
