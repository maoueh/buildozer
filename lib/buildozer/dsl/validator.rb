require 'buildozer/dsl/exceptions'
require 'buildozer/dsl/validator/definition'
require 'buildozer/dsl/validator/package'
require 'buildozer/dsl/validator/source'
require 'buildozer/helper/string'

module Buildozer
  module Dsl
    module Validator
      ##
      # Receive a dsl fragment and validates that it is
      # well-formed. A dsl fragment is any valid dsl
      # class that can be compiled.
      #
      # For now, exceptions are raised when something is wrong.
      def self.validate(fragment)
        if not fragment.kind_of?(Dsl::Core::Fragment) or not fragment.respond_to?(:type)
          raise InvalidDslFragment, "Cannot validate, the argument received is not a dsl fragment"
        end

        type = fragment.type()
        validator = get_validator(type)
        raise InvalidDslFragment, "Does not know how to compile fragment [#{type}]" if not validator

        validator.send(:validate, fragment)
      end

      def self.get_validator(type)
        Validator.const_get(Helper::String.camelize(type.to_s()))
      rescue NameError
        nil
      end
    end
  end
end
