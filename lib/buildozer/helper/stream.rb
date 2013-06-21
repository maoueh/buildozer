require 'fileutils'
require 'net/http'
require 'uri'

module Buildozer
  module Helper
    module Stream
      def self.fetch_file(source, destination)
        # TODO: Log file does not exist
        if not File.exists?(source)
          return false
        end

        FileUtils.cp(source, destination)
      end

      def self.fetch_url(url, destination)
        Net::HTTP.new(url.host, url.port).request_get(url.path) do |response|
          output = File.open(destination, "wb")
          begin
            response.read_body do |fragment|
              output << fragment
            end
          ensure
            output.close()
          end
        end
      end
    end
  end
end
