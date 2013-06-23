require 'buildozer/model/source'

module Buildozer
  module Dsl
    module Compiler
      class Source
        ##
        # Function that receives a dsl source and compile
        # it to a model package. This compilation is done
        # mainly to report user-friendly error when dsl
        # source is invalid
        def self.compile(source)
          return Model::Source.new(source.options())
        end
      end
    end
  end
end
