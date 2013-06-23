module Buildozer
  module Model
    class Definition
      attr_accessor :name, :version, :maintainer, :source, :packages
      def initialize(options)
        @name = options.fetch(:name)
        @version = options.fetch(:version)
        @maintainer = options.fetch(:maintainer, nil)
        @source = options.fetch(:source)
        @packages = options.fetch(:packages)
      end
    end
  end
end
