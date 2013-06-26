require 'net/http'
require 'uri'

require 'buildozer/model/extractor/tar_gz'
require 'buildozer/model/extractor/zip'

module Buildozer
  module Model
    module Fetcher
      class Url
        attr_reader :uri, :archive, :extension

        def initialize(url)
          @uri = URI.parse(url)
          @archive = @uri.path().split("/").last()
        end

        def from()
          @uri.to_s()
        end

        def fetch(options = {})
          destination = fetch_destination(options)
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

          # TODO: Make extraction here
          extractor = find_extractor(destination)
          extractor.extract(options)
        end

        def fetch_destination(options)
          File.expand_path("#{options[:destination] || "."}/#{@archive}")
        end

        def find_extractor(archive)
          case
          when archive.ends_with?(".zip")
            return Model::Extractor::Zip.new(archive)
          when archive.ends_with?(".tar.gz")
            return Model::Extractor::TarGz.new(archive)
          else
            # TODO Add custom exception
            raise "Don't know how to extract #{archive} yet"
          end
        end
      end
    end
  end
end
