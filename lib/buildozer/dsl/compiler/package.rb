require 'buildozer/model/package'

module Buildozer
  module Dsl
    module Compiler
      class Package
        ##
        # Function that receives a dsl package and compile
        # it to a model package. This compilation is done
        # mainly to report user-friendly error when dsl
        # package is invalid
        def self.compile(package)
          return Model::Package.new(package.options())
        end
      end
    end
  end
end
