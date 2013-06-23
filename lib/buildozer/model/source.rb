module Buildozer
  module Model
    class Source
      attr_accessor :from

      def initialize(options)
        @from = options.fetch(:from)
      end
    end
  end
end
