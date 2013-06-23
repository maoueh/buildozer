require 'buildozer/dsl/compiler/definition'
require 'buildozer/dsl/compiler/package'
require 'buildozer/dsl/compiler/source'
require 'buildozer/dsl/validator'
require 'buildozer/helper/string'

module Buildozer
  module Dsl
    module Compiler
      def self.compile(fragment)
        Validator.validate(fragment);

        type = fragment.type()
        compiler = get_compiler(type)
        raise InvalidDslFragment, "Does not know how to compile fragment [#{type}]" if not compiler

        compiler.send(:compile, fragment)
      end

      def self.get_compiler(type)
        Compiler.const_get(Helper::String.camelize(type.to_s()))
      rescue NameError
        nil
      end
    end
  end
end
