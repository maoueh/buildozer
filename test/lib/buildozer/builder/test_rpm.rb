require 'buildozer/builder/exceptions'
require 'buildozer/builder/rpm'
require 'buildozer/dsl/compiler'
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
          :includes => ["usr/bin"],
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

      def test_package_no_includes()
        package = base_package({:includes => []})

        assert_raise(Builder::InvalidRpmPackage) do
          Builder::Rpm.new(package, ".")
        end
      end
    end
  end
end
