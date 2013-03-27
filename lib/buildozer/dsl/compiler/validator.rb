module Buildozer
  module Dsl
    module Compiler
      module Validator
        ##
        # Receive a dsl fragment and validates that it is
        # well-formed. A dsl fragment is any valid dsl
        # class that can be compiled.
        #
        # For now, exceptions are raised when something is wrong.
        def self.validate_fragment(fragment)
          if not fragment.kind_of?(Fragment) or not fragment.respond_to?(:type)
            raise InvalidDslFragment, "Cannot compile, the argument received is not a dsl fragment"
          end

          compiler = "compile_#{fragment.type()}"
          if not Compiler.respond_to?(compiler)
            raise InvalidDslFragment, "Does not know how to compile fragment [#{fragment.type()}]"
          end
        end

        ##
        # Receive a dsl definition and validates that it is
        # well-formed.
        #
        # For now, exceptions are raised when something is wrong.
        def self.validate_definition(definition)
          options = definition.options()
          if not options.has_key?(:packages) or options[:packages].empty?()
            raise InvalidDslDefinition, "Invalid definition, must have a least one 'package'"
          end
        end

        ##
        # Receive a dsl package and validates that it is
        # well-formed.
        #
        # For now, exceptions are raised when something is wrong.
        def self.validate_package(package)
          options = package.options()
          if not options.has_key?(:version)
            raise InvalidDslPackage, "Invalid package, must have a 'version'"
          end

          if not options.has_key?(:url)
            raise InvalidDslPackage, "Invalid package, must have an 'url'"
          end

          if options.has_key?(:architecture)
            architecture = options[:architecture]

            validate_architecture(architecture)
          end
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
