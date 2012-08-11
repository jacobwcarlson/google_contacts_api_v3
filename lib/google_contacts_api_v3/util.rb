module GoogleContactsApiV3
  module Util
    # Utility method to pull values from a Google JSON map in a safe way.
    def self.get_hash_val(map, val_name, sub_val_name = '$t')
      return map[val_name][sub_val_name] if map[val_name]

      nil
    end # get_tval
  end # module Util
end # module GContactsApiV3
