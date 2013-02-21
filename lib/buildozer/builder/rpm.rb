require 'buildozer/builder/exceptions'
require 'stringio'

module Buildozer
  module Builder
    class Rpm
      def initialize(package, directory)
        @package = package
        @directory = directory

        validate()
      end

      def build()
        system(command())
      end

      def command()
        buffer = StringIO.new

        buffer << "fpm -s dir -t rpm"
        buffer << " -n \"#{@package.name}\""
        buffer << " -v \"#{@package.version}\""
        buffer << " -C \"#{@directory}\""
        buffer << " -p \"#{name()}\""

        buffer << " -m \"#{@package.maintainer}\"" if @package.maintainer

        @package.provides.each do |provide|
          buffer << " --provides \"#{provide}\""
        end

        @package.depends.each do |dependency|
          buffer << " -d \"#{dependency}\""
        end

        @package.includes.each do |entry|
          buffer << " #{entry}"
        end

        return buffer.string
      end

      def name()
        "#{@package.archive}_ARCH.rpm"
      end

      def validate()
        if @package.includes.empty?()
          raise Builder::InvalidRpmPackage, "Invalid rpm package, must have at least on 'includes'"
        end
      end
    end
  end
end
