require 'buildozer/builder/rpm'
require 'buildozer/dsl'
require 'thor'

module Buildozer
  module Cli
    class Buildozer < Thor

      desc "rpm FILE", "Build a rpm package using fpm"
      def rpm(file)
        definition = Dsl.compile(file)

        definition.packages.each do |package|
          builder = Builder::Rpm.new(package,  "/tmp")
          puts builder.command()
        end
      end
    end
  end
end
