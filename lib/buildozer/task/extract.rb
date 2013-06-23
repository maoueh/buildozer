require 'buildozer/helper/stream'

module Buildozer
  module Task
    class Extract
      def initialize(definition, options = {})
        @definition = definition
        @destination = options.fetch(:destination, Dir.getwd())
      end

      def depends()
        [
          Task::Fetch.new(definition, :destination => @destination)
        ]
      end

      def execute()
        depends().each do |task|
          task.execute()
        end

        uri = URI.parse(@definition.source.url)
        archive = File.expand_path("#{@destination}/#{find_archive_name(uri)}")

        puts "Extracting source archive from #{archive}"

      end
    end

    class ExtractHandler
      def extract(archive, options = {})

      end
    end

    class NativeExtractHandler
      def self.supported?(archive)
        # FIXME: Check
        true
      end

      def extract(archive, options = {})

      end
    end
  end
end
