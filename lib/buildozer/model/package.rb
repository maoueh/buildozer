module Buildozer
  module Model
    class Package
      attr_accessor :name, :version, :revision, :archive, :url,
                    :provides, :dependencies, :includes

      def initialize(options)
        @name = options.fetch(:name)
        @version = options.fetch(:version)
        @revision = options.fetch(:revision, nil)
        @archive = options.fetch(:archive, "#{@name}-#{@version}")
        @url = options.fetch(:url)

        @provides = options.fetch(:provides, [])
        @dependencies = options.fetch(:dependencies, [])

        @includes = options.fetch(:includes, [])
      end
    end
  end
end
