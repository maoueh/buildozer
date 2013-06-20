require 'optparse'

require 'buildozer/cli/core/helper'

module Buildozer
  module Cli
    module Core
      class Base
        def initialize(arguments = ARGV, options = {})
          @arguments = arguments
        end

        ##
        # Specify the name of the command. Used as the default
        # name when usage is not defined. So with this, it is
        # possible to just specify a command name and then
        # let base class handles the rest.
        def name()
          self.class.name.split("::").last().downcase()
        end

        ##
        # Specify the description of this command.
        # Overriding classes just need to return a
        # string that will be output to terminal
        # as-is. No formatting occurs.
        def usage()
          "Usage: #{name()} (options)"
        end

        ##
        # Specify the description of this command.
        # Overriding classes just need to return a
        # string that will be formatted correctly
        # for the terminal.
        #
        # Return nil if you dont want a description,
        # this is the default.
        def description()
          nil
        end

        ##
        # Specify the tail of this command.
        # Overriding classes just need to return a
        # string that will be formatted correctly
        # for the terminal.
        def tail()
          "Available options:"
        end

        ##
        # Specify additional arguments parse options
        # Use OptoinParser syntax
        def options(parser)
          parser.on_tail("-h", "--help", "Show help") do
            help()
          end
        end

        ##
        # This is the method that will be invoked to
        # execute the cli command task.
        def execute()
        end

        ##
        # Show command help for this instance and exit
        # with code 0.
        def help()
          puts @parser
          exit(0)
        end

        def run()
          @parser = parser()
          @arguments = parser.parse(@arguments)

          execute()
        end

        def parser()
          return @parser if @parser

          parser = OptionParser.new()

          set_usage(parser)
          set_description(parser)

          options(parser)

          set_tail(parser)
          parser
        end

        def set_usage(parser)
          parser.banner = usage()
        end

        def set_description(parser)
          set_text(description(), parser,
            :prepend_newline => true,
            :max_width => 80
          )
        end

        def set_tail(parser)
          set_text(tail(), parser,
            :prepend_newline => true,
            :max_width => 80
          )
        end

        def set_text(text, parser, options = {})
          return if not text

          parser.separator("") if options[:prepend_newline]

          lines = text
          lines = Helper::format_text(text, :max_width => options[:max_width]) if not lines.kind_of?(Array)
          lines.each do |line|
            parser.separator(line)
          end

          parser.separator("") if options[:append_newline]
        end
      end
    end
  end
end
