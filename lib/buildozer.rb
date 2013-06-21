require 'buildozer/dsl'
require 'buildozer/dsl/compiler'

module Buildozer
  def self.load(path)
    fragment = Dsl.load(path)
     return Dsl::Compiler.compile(fragment)
  end
end
