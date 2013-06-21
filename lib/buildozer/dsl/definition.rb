require 'buildozer/dsl/fragment'
require 'buildozer/dsl/package'
require 'buildozer/dsl/source'

module Buildozer
  module Dsl
    class Definition < Fragment
      def initialize()
        @packages = []
      end

      def name(name)
        @name = name
      end

      def version(version)
        @version = version
      end

      def maintainer(maintainer)
        @maintainer = maintainer
      end

      def source(&block)
        @source = Source.new(&block)

        return @source
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
