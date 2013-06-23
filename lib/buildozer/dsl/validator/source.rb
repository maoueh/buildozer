require 'buildozer/dsl/source'
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
          if not source.kind_of?(Dsl::Source)
            raise InvalidDslSource, "Cannot validate, the argument received is not a dsl source"
          end

          options = source.options()

          if not options.has_key?(:url)
            raise InvalidDslSource, "Invalid source, must have an 'url'"
          end
        end
      end
    end
  end
end

