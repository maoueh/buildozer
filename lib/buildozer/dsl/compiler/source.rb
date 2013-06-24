require 'uri'

require 'buildozer/dsl/exceptions'
require 'buildozer/model/fetcher/url'
require 'buildozer/model/source'

module Buildozer
  module Dsl
    module Compiler
      class Source
        ##
        # Function that receives a dsl source and compile
        # it to a model source. This compilation is done
        # mainly to report user-friendly error when dsl
        # source is invalid
        def self.compile(source)
          options = source.options()

          fetcher = find_fetcher(options[:from])
          if not fetcher
            raise InvalidDslSource, "Only [http/https] url can be specified for source 'from' attribute yet."
          end

          return Model::Source.new({
            :fetcher => fetcher
          })
        end

        def self.find_fetcher(from)
          uri = URI.parse(from)
          scheme = uri.scheme()

          if scheme == "http" || scheme == "https"
            return Model::Fetcher::Url.new(from)
          end
        end
      end
    end
  end
end
