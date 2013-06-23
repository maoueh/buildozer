module Buildozer
  module Helper
    module String
      def self.camelize(input)
        return nil if not input

        parts = input.split(/_/).map do |part|
          part.capitalize()
        end

        parts.join("")
      end

      def self.format_text(text, options = {})
        tokens = tokenize(text)
        tokens_to_lines(tokens, options)
      end

      def self.tokenize(text)
        text.scan(/([^\s]+)|(\s+)/).map do |word, space|
          { :text => word ||space, :type => word ? :word : :space }
        end
      end

      def self.tokens_to_lines(tokens, options = {})
        max_width = options[:max_width] || 80;
        indentation = options[:indentation] || ""

        lines = []
        buffer = indentation

        tokens.each do |token|
          text = token[:type] == :space ? " " : token[:text]
          potential_width = text.length() + buffer.length()
          if potential_width > max_width
            lines << normalize_line(buffer)
            buffer = indentation
          end

          buffer += text
        end

        lines << normalize_line(buffer)
        lines
      end

      def self.normalize_line(line, options = {})
        line.strip()
      end
    end
  end
end
