require 'buildozer/helper/stream'

module Buildozer
  module Task
    class Fetch
      def initialize(definition, options = {})
        @definition = definition
        @destination = options.fetch(:destination, Dir.getwd())
      end

      def execute()
        fetcher = @definition.source.fetcher

        puts "Fetching source from #{fetcher.from()}"
        fetcher.fetch(:destination => @destination)
      end
    end
  end
end
