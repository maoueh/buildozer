require 'buildozer/builder/exceptions'
require 'buildozer/builder/rpm'
require 'buildozer/dsl/compiler'
require 'buildozer/model/package'
require 'test/unit'

module Buildozer
  module Builder
    class TestRpm < Test::Unit::TestCase
      def setup()
        @definition = {
          :name => "dummy",
          :version => "1.5.2",
        }

        @source = {
          :from => "http://localhost/archive.tar.gz",
        }

        @package = {
          :name => "dummy",
          :includes => ["usr/bin"],
        }
      end

      def base_definition(options = {})
        source = Model::Source.new(@source.merge(options[:source] || {}))
        package = Model::Package.new(@package.merge(options[:package] || {}))

        definition = @definition.merge(options[:definition] || {})
        definition[:source] = source if not definition[:source]
        definition[:packages] = [package] if not definition[:packages]

        Model::Definition.new(definition)
      end

      def test_command_without_architecture()
        definition = base_definition()
        command = Builder::Rpm.new(definition, definition.packages[0], ".").command()

        assert(command !~ /-a/, "Architecture flag [-a] should NOT be present in #{command}")
      end

      def test_command_with_architecture()
        definition = base_definition(:package => {:architecture => "i989"})
        command = Builder::Rpm.new(definition, definition.packages[0], ".").command()

        assert(command =~ /-a "i989"/, "Architecture flag [-a i989] should be present in #{command}")
      end

      def test_command_with_architecture_auto()
        definition = base_definition(:package => {:architecture => :auto})
        command = Builder::Rpm.new(definition, definition.packages[0], ".").command()

        assert(command !~ /-a/, "Architecture flag [-a] should NOT be present in #{command}")
      end

      def test_command_without_maintainer()
        definition = base_definition()
        command = Builder::Rpm.new(definition, definition.packages[0], ".").command()

        assert(command !~ /-m/, "Maintainer flag [-m] should NOT be present in #{command}")
      end

      def test_command_with_maintainer()
        definition = base_definition(:definition => {:maintainer => "Joe Armstrong"})
        command = Builder::Rpm.new(definition, definition.packages[0], ".").command()

        assert(command =~ /-m "Joe Armstrong"/, "Maintainer flag [-m Joe Armstrong] should be present in #{command}")
      end

      def test_package_no_includes()
        definition = base_definition(:package => {:includes => []})

        assert_raise(Builder::InvalidRpmPackage) do
          Builder::Rpm.new(definition, definition.packages[0], ".")
        end
      end
    end
  end
end
