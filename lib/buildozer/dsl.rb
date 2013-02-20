require 'buildozer/dsl/definition'

module Buildozer
  module Dsl
    def self.load(filename)
      definition = Dsl::Definition.new()
      definition.instance_eval(File.read(filename), filename)

      return definition
    end
  end
end
