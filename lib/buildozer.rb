require 'buildozer/package/descriptor'

module Buildozer
  class Dsl
    def package(name, &block)
      return Package::Descriptor.new(name, &block)
    end
  end

  def self.load(filename)
    dsl = Dsl.new
    dsl.instance_eval(File.read(filename), filename)
    dsl
  end
end
