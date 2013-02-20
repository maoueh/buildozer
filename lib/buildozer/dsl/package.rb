require 'buildozer/dsl/fragment'

module Buildozer
  module Dsl
    class Package < Fragment
      def initialize(name, &block)
        @name = name
        @provides = []
        @depends = []

        if block_given?
          instance_eval(&block)
        end
      end

      def url(url)
        @url = url
      end

      def version(version)
        @version = version
      end

      def archive(archive)
        @archive = archive
      end

      def depends(package)
        @depends << package
      end

      def provides(package)
        @provides << package
      end

      def includes(entry)
        @incudes << entry
      end

      def type()
        return :package
      end
    end
  end
end
