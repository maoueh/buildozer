require 'buildozer/dsl/core/definition'
require 'buildozer/dsl/exceptions'

module Buildozer
  module Dsl
    module Validator
      class Definition
        ##
         # Receive a dsl definition and validates that it is
         # well-formed.
         #
         # For now, exceptions are raised when something is wrong.
         def self.validate(definition)
           if not definition.kind_of?(Dsl::Core::Definition)
             raise InvalidDslDefinition, "Cannot validate, the argument received is not a dsl definition"
           end

           options = definition.options()
           if not options.has_key?(:name)
             raise InvalidDslDefinition, "Invalid Buildozer definition, must have a 'name'"
           end

           if not options.has_key?(:version)
             raise InvalidDslDefinition, "Invalid Buildozer definition, must have a 'version'"
           end

           if not options.has_key?(:source)
             raise InvalidDslDefinition, "Invalid Buildozer definition, must have a 'source'"
           end

           if not options.has_key?(:packages) or options[:packages].empty?()
             raise InvalidDslDefinition, "Invalid Buildozer definition, must have a least one 'package'"
           end
         end
      end
    end
  end
end
