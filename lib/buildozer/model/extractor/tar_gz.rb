require 'buildozer/model/extractor/base'

module Buildozer
  module Model
    module Extractor
      class TarGz < Base
        def extract(options = {})
          destination = fetch_destination(options)
          return if File.exists?(destination)

          # TODO: Add pure ruby fallback
          system("tar -xzv #{@archive} -C #{destination}")
        end
      end
    end
  end
end
