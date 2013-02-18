module Buildozer
  module Package
    class Descriptor
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

      def package(package)
        @package = package
      end

      def depends(package)
        @depends << package
      end

      def provides(package)
        @provides << package
      end
    end
  end
end
