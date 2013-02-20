module Buildozer
  module Model
    class Package
      attr_accessor :name, :version, :revision, :archive, :url,
                    :provides, :depends, :includes

      def initialize(options)
        @name = options.fetch(:name)
        @version = options.fetch(:version)
        @revision = options.fetch(:revision, nil)
        @archive = options.fetch(:archive, "#{@name}-#{@version}")
        @url = options.fetch(:url)

        @provides = options.fetch(:provides, [])
        @depends = options.fetch(:depends, [])

        @includes = options.fetch(:includes, [])
      end
    end
  end
end
