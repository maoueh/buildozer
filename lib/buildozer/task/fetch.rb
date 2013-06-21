require 'buildozer/helper/stream'

module Buildozer
  module Task
    class Fetch
      def initialize(definition, options = {})
        @definition = definition
        @destination = options.fetch(:destination, Dir.getwd())
      end

      def execute()
        uri = URI.parse(@definition.source.url)
        destination = File.expand_path("#{@destination}/#{find_archive_name(uri)}")
        if File.exists?(destination)
          return
        end

        puts "Fetching source from #{uri} to #{destination}"
        Helper::Stream.fetch_url(uri, destination)
      end

      def find_archive_name(uri)
        uri.path().split("/").last()
      end
    end
  end
end
