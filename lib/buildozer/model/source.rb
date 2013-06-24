module Buildozer
  module Model
    class Source
      attr_accessor :fetcher

      def initialize(options)
        @fetcher = options.fetch(:fetcher)
      end
    end
  end
end
