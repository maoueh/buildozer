require 'buildozer/dsl/compiler'
require 'buildozer/model/definition'

module Buildozer
  module Dsl
    module Compiler
      class Definition
        ##
        # Function that receives a dsl definition and compile
        # it to a model definition. This compilation is done
        # mainly to report user-friendly error when dsl
        # definition is invalid
        def self.compile(definition)
          options = definition.options()

          # Perform some further compilation
          options[:source] = Compiler.compile(options[:source])
          options[:packages] = options[:packages].map do |package|
            Compiler.compile(package)
          end

          return Model::Definition.new(options)
        end
      end
    end
  end
end
