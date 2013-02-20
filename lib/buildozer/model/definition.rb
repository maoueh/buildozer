module Buildozer
  module Model
    class Definition
      attr_accessor :packages

      def initialize(options)
        @packages = options.fetch(:packages)
      end
    end
  end
end
