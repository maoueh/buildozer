require 'buildozer/dsl/core/source'
require 'buildozer/dsl/exceptions'

module Buildozer
  module Dsl
    module Validator
      class Source
        ##
        # Receive a dsl source and validates that it is
        # well-formed.
        #
        # For now, exceptions are raised when something is wrong.
        def self.validate(source)
          if not source.kind_of?(Dsl::Core::Source)
            raise InvalidDslSource, "Cannot validate, the argument received is not a dsl source"
          end

          options = source.options()

          if not options.has_key?(:from)
            raise InvalidDslSource, "Invalid source, must have a 'from' attribute"
          end
        end
      end
    end
  end
end

