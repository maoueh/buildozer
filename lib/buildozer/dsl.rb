require 'buildozer/dsl/compiler'
require 'buildozer/dsl/core/definition'

module Buildozer
  module Dsl
    def self.load(filename)
      definition = Dsl::Core::Definition.new()
      definition.instance_eval(File.read(filename), filename)

      return definition
    end

    def self.compile(filename)
      fragment = load(filename)

      return Dsl::Compiler.compile(fragment)
    end
  end
end
