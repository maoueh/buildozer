require 'net/http'
require 'uri'

module Buildozer
  module Model
    module Fetcher
      class Url
        def initialize(url)
          @uri = URI.parse(url)
        end

        def from()
          @uri.to_s()
        end

        def fetch(options = {})
          destination = File.expand_path("#{options[:destination] || File.expand_path(".")}/#{find_archive_name()}")

          return if File.exists?(destination)

          Net::HTTP.new(@uri.host, @uri.port).request_get(@uri.path) do |response|
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

        def find_archive_name()
          @uri.path().split("/").last()
        end
      end
    end
  end
end
