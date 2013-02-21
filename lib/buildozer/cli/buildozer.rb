require 'buildozer/builder/rpm'
require 'buildozer/dsl'
require 'thor'

module Buildozer
  module Cli
    class Buildozer < Thor

      desc "rpm FILE", "Build a rpm package using fpm"
      method_option :dir, :aliases => "-d", :default => ".", :desc => "Directory where package files are located"
      def rpm(file)
        definition = Dsl.compile(file)

        definition.packages.each do |package|
          builder = Builder::Rpm.new(package, File.expand_path(options[:dir]))
          puts builder.build()
        end
      end
    end
  end
end
