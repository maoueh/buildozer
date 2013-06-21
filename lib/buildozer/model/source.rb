module Buildozer
  module Model
    class Source
      attr_accessor :url

      def initialize(options)
        @url = options.fetch(:url)
      end
    end
  end
end
