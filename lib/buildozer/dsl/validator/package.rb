require 'buildozer/dsl/core/package'
require 'buildozer/dsl/exceptions'

module Buildozer
  module Dsl
    module Validator
      class Package
        ##
        # Receive a dsl package and validates that it is
        # well-formed.
        #
        # For now, exceptions are raised when something is wrong.
        def self.validate(package)
          if not package.kind_of?(Dsl::Core::Package)
             raise InvalidDslPackage, "Cannot validate, the argument received is not a dsl package"
           end

          options = package.options()

          validate_architecture(options[:architecture]) if options[:architecture]
        end

        def self.validate_architecture(architecture)
          if architecture == :auto or (architecture.kind_of?(String) and not architecture == "")
            return
          end

          raise InvalidDslPackage, "Invalid package, architecture must be :auto or a non-empty String, currently [#{architecture}]"
        end
      end
    end
  end
end
