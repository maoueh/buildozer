require 'buildozer/dsl/compiler/validator'
require 'buildozer/dsl/compiler/exceptions'
require 'buildozer/model/definition'
require 'buildozer/model/package'
require 'buildozer/model/source'

module Buildozer
  module Dsl
    module Compiler
      def self.compile(fragment)
        Validator.validate_fragment(fragment);

        send("compile_#{fragment.type()}", fragment)
      end

      ##
      # Function that receives a dsl definition and compile
      # it to a model definition. This compilation is done
      # mainly to report user-friendly error when dsl
      # definition is invalid
      def self.compile_definition(definition)
        Validator.validate_definition(definition);

        options = definition.options()

        # Perform some further compilation
        options[:source] = compile(options[:source])
        options[:packages] = options[:packages].map { |package| compile(package) }

        return Model::Definition.new(options)
      end

      ##
      # Function that receives a dsl source and compile
      # it to a model package. This compilation is done
      # mainly to report user-friendly error when dsl
      # source is invalid
      def self.compile_source(source)
        Validator.validate_source(source);

        return Model::Source.new(source.options())
      end

      ##
      # Function that receives a dsl package and compile
      # it to a model package. This compilation is done
      # mainly to report user-friendly error when dsl
      # package is invalid
      def self.compile_package(package)
        Validator.validate_package(package);

        return Model::Package.new(package.options())
      end
    end
  end
end
