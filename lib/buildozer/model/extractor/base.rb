module Buildozer
  module Model
    module Extractor
      class Base
        def initialize(archive)
          @archive = archive
        end

        def fetch_destination(options)
          options[:destination] || "."
        end

        def from()
          @archive.to_s()
        end
      end
    end
  end
end
