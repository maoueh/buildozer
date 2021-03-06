require 'buildozer/builder/exceptions'
require 'stringio'

module Buildozer
  module Builder
    class Rpm
      def initialize(definition, package, directory)
        @definition = definition
        @package = package
        @directory = directory

        validate()
      end

      def build()
        system(command())
      end

      def show()
        puts(command())
      end

      def command()
        buffer = StringIO.new

        buffer << "fpm -s dir -t rpm"
        buffer << " -n \"#{@definition.name}\""
        buffer << " -v \"#{@definition.version}\""
        buffer << " -C \"#{@directory}\""
        buffer << " -p \"#{name()}\""

        buffer << " -m \"#{@definition.maintainer}\"" if @definition.maintainer

        if @package.architecture and not @package.architecture == :auto
          buffer << " -a \"#{@package.architecture}\""
        end

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
        "#{@definition.name}-#{@definition.version}_ARCH.rpm"
      end

      def validate()
        if @package.includes.empty?()
          raise Builder::InvalidRpmPackage, "Invalid rpm package, must have at least one 'includes'"
        end
      end
    end
  end
end
