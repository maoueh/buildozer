require 'buildozer/builder/rpm'
require 'buildozer/model/package'
require 'test/unit'

module Buildozer
  module Builder
    class TestRpm < Test::Unit::TestCase
      def setup()
        @defaults = {
          :name => "dummy",
          :version => "1.5.2",
          :url => "http://localhost/archive.tar.gz",
        }
      end

      def base_package(options = {})
        Model::Package.new(@defaults.merge(options))
      end

      def test_command_without_maintainer()
        package = base_package()
        command = Builder::Rpm.new(package, ".").command()

        assert(command !~ /-m/)
      end

      def test_command_with_maintainer()
        package = base_package({:maintainer => "Joe Armstrong"})
        command = Builder::Rpm.new(package, ".").command()

        assert(command =~ /-m "Joe Armstrong"/)
      end
    end
  end
end
