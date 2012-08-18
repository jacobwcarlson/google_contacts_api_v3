module GoogleContactsApiV3
  module Util
    # Utility method to pull values from a Google JSON map in a safe way.
    def self.get_text_val(map, val_name, sub_val_name = '$t')
      return map[val_name][sub_val_name] if map[val_name]

      nil
    end

    def self.is_true?(str)
      str.to_s.downcase == "true" ? true : false
    end
  end # module Util
end # module GContactsApiV3
