module Buildozer
  module Model
    class Package
      attr_accessor :name,
                    :architecture,
                    :provides, :depends,
                    :includes

      def initialize(options)
        @name = options.fetch(:name)
        @architecture = options.fetch(:architecture, :auto)

        @provides = options.fetch(:provides, [])
        @depends = options.fetch(:depends, [])

        @includes = options.fetch(:includes, [])
      end
    end
  end
end
