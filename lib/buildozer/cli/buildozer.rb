require 'buildozer/builder/rpm'
require 'buildozer/dsl'
require 'thor'

module Buildozer
  module Cli
    class Buildozer < Thor

      desc "rpm DEFINITION_FILE", "Build a rpm package using fpm"
      method_option :dir, :aliases => "-d", :default => ".", :type => :string, :desc => "Directory where package files are located"
      method_option :"dry-run", :aliases => "-n", :default => false, :type => :boolean, :desc => "Only show commands that would be exectued without actually running them"
      def rpm(definition_file)
        definition = Dsl.compile(definition_file)

        definition.packages.each do |package|
          builder = Builder::Rpm.new(package, File.expand_path(options[:dir]))

          builder.build() if not options[:"dry-run"]
          builder.show() if options[:"dry-run"]
        end
      end
    end
  end
end
