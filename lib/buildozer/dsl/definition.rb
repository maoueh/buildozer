require 'buildozer/dsl/fragment'
require 'buildozer/dsl/package'

module Buildozer
  module Dsl
    class Definition < Fragment
      def initialize()
        @packages = []
      end

      def package(name, &block)
        package = Package.new(name, &block)
        @packages << package

        return package
      end

      def type()
        return :definition
      end
    end
  end
end
