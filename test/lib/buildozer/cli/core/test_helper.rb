require 'buildozer/cli/core/helper'
require 'test/unit'

module Buildozer
  module Cli
    module Core
      class TestHelper < Test::Unit::TestCase
        def test_tokenize()
          text = "  first second "
          tokens = Helper.tokenize(text)

          assert_equal([
            { :text => "  ", :type => :space},
            { :text => "first", :type => :word},
            { :text => " ", :type => :space},
            { :text => "second", :type => :word},
            { :text => " ", :type => :space}], tokens)
        end

        def test_tokenize_with_line_breaks()
          text = <<-EOC
            first
              second
            third
          EOC
          tokens = Helper.tokenize(text)

          assert_equal([
            {:text => "            ", :type => :space},
            {:text => "first", :type => :word},
            {:text => "\n              ", :type => :space},
            {:text => "second", :type => :word},
            {:text => "\n            ", :type => :space},
            {:text => "third", :type => :word},
            {:text => "\n", :type => :space}], tokens)
        end

        def test_format_text_simple()
          text = <<-EOC
              Donec ornare consectetur ante non porttitor. Lorem ipsum dolor
              sit amet, consectetur adipiscing elit. Ut consequat lacinia ero.
          EOC

          assert_equal([
            "Donec ornare consectetur ante non",
            "porttitor. Lorem ipsum dolor sit amet,",
            "consectetur adipiscing elit. Ut",
            "consequat lacinia ero."
          ], Helper.format_text(text, :max_width => 40))
        end

        def test_format_text_advanced()
          text = <<-EOC
                    Lorem ipsum dolor sit amet,
        consectetur adipiscing elit. Nam egestas "feugiat" quam sed vehicula. Integer placerat;

        odio
        in condimentum pretium. Nullam at porta lacus, non euismod purus.
        Donec ornare consectetur ante non porttitor. Lorem ipsum dolor
        sit amet, consectetur adipiscing elit. Ut consequat lacinia ero.
          EOC

          assert_equal([
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam egestas \"feugiat\"",
            "quam sed vehicula. Integer placerat; odio in condimentum pretium. Nullam at",
            "porta lacus, non euismod purus. Donec ornare consectetur ante non porttitor.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat lacinia",
            "ero."
          ], Helper.format_text(text, :max_width => 80))
        end
      end
    end
  end
end
