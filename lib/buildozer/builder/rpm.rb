require 'stringio'

module Buildozer
  module Builder
    class Rpm
      def initialize(package, directory)
        @package = package
        @directory = directory
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
        "#{@package.archive}_ARCH.el6.rpm"
      end
    end
  end
end
