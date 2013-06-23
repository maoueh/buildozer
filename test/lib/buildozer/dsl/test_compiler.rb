require 'buildozer/dsl'
require 'buildozer/dsl/compiler'
require 'buildozer/dsl/exceptions'
require 'buildozer/dsl/fragment'
require 'test/unit'

module Buildozer
  module Dsl
    class TestCompiler < Test::Unit::TestCase
      def compile(definition_filename)
        path = File.expand_path("#{File.dirname(__FILE__)}/../../../resources/#{definition_filename}")
        fragment = Dsl.load(path)

        return Compiler.compile(fragment)
      end

      def test_compile()
        definition = compile("definition_full.bd.rb")
        assert(definition.instance_of?(Model::Definition))

        assert_equal("erlang", definition.name)
        assert_equal("R15B03", definition.version)
        assert_equal("Nu Echo (Matthieu Vachon)", definition.maintainer)

        source = definition.source
        assert_equal("http://www.erlang.org/download/otp_src_R15B03-1.tar.gz", source.from)

        packages = definition.packages
        assert_equal(1, packages.size())

        package = packages[0]
        assert_equal("i989", package.architecture)
      end

      def test_invalid_fragment_no_type()
        assert_raise(Dsl::InvalidDslFragment) do
          Compiler.compile(FakeFragment.new())
        end
      end

      def test_invalid_fragment_unknown_type()
        assert_raise(Dsl::InvalidDslFragment) do
          Compiler.compile(FakeFragmentInvalidType.new())
        end
      end

      def test_invalid_definition()
        assert_raise(Dsl::InvalidDslDefinition) do
          Compiler.compile(Definition.new())
        end
      end

      def test_no_includes()
        definition = compile("definition_no_includes.bd.rb")
        package = definition.packages.first

        assert_equal([], package.includes)
      end

      def test_architecture_auto()
        definition = compile("definition_architecture_auto.bd.rb")
        packages = definition.packages
        assert_equal(1, packages.size())

        package = packages[0]
        assert_equal(:auto, package.architecture)
      end

      def test_invalid_architecture()
        assert_raise(Dsl::InvalidDslPackage) do
          compile("definition_invalid_architecture.bd.rb")
        end
      end
    end

    class FakeFragment < Fragment
      def type()
        return :fragment
      end
    end

    class FakeFragmentInvalidType < Fragment
      def type()
        return :element
      end
    end
  end
end
