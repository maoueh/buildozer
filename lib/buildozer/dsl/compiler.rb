require 'buildozer/dsl/compiler/validator'
require 'buildozer/dsl/compiler/exceptions'
require 'buildozer/model/definition'
require 'buildozer/model/package'

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
        return Model::Definition.new({
          :packages => options[:packages].map { |package| compile(package) }
        })
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
