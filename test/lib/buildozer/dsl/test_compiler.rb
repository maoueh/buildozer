require 'buildozer/dsl'
require 'buildozer/dsl/compiler'
require 'buildozer/dsl/compiler/exceptions'
require 'buildozer/dsl/fragment'
require 'test/unit'

module Buildozer
  module Dsl
    class TestCompiler < Test::Unit::TestCase
      def load(definition_filename)
        path = File.expand_path("#{File.dirname(__FILE__)}/../../../resources/#{definition_filename}")

        return Dsl.load(path)
      end

      def test_compile()
        fragment = load("package_descriptor1.bd.rb")
        definition = Compiler.compile(fragment)
        assert(definition.instance_of?(Model::Definition))

        packages = definition.packages
        assert_equal(1, packages.size())

        package = packages[0]
        assert_equal("erlang", package.name)
        assert_equal("http://www.erlang.org/download/otp_src_R15B03-1.tar.gz", package.url)
        assert_equal("R15B03", package.version)
        assert_equal("erlang-R15B03", package.archive)
      end

      def test_invalid_fragment_no_type()
        assert_raise(Compiler::InvalidDslFragment) do
          Compiler.compile(FakeFragment.new())
        end
      end

      def test_invalid_fragment_unknown_type()
        assert_raise(Compiler::InvalidDslFragment) do
          Compiler.compile(FakeFragmentInvalidType.new())
        end
      end

      def test_invalid_definition()
        assert_raise(Compiler::InvalidDslDefinition) do
          Compiler.compile(Definition.new())
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
