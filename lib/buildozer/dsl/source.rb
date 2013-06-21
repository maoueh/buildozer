require 'buildozer/dsl/fragment'

module Buildozer
  module Dsl
    class Source < Fragment
      def initialize(&block)
        if block_given?
          instance_eval(&block)
        end
      end

      def url(url)
        @url = url
      end

      def archive(archive)
        @archive = archive
      end

      def type()
        return :source
      end
    end
  end
end
