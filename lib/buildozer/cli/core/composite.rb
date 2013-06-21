require 'buildozer/cli/core/base'

module Buildozer
  module Cli
    module Core
      class Composite < Core::Base
        def initialize(arguments = ARGV)
          super(arguments)

          @arguments, @command, @subarguments = split_arguments(arguments)
          @subcommands = subcommands()

          raise "You must provide at least one subcommand in #{self.class}" if !@subcommands || @subcommands.empty?()
        end

        ##
        # Default implementation of description for composite
        # commands.
        def description()
          lines = ["Available subcommands:", ""]

          @subcommands.keys().sort().each do |key|
            lines << "     #{key}"
          end

          lines
        end

        ##
        # Method to be overriden in child classes to specify
        # the map of subcommands available to the user.
        #
        # The key of the map is a symbol reprensenting the
        # command name and the value is a constant representing
        # the class to instantiate when the command name is used
        # by the user.
        #
        # For example:
        #   { :build => Namespace::Build, :destroy => Namespace::Destroy }
        #
        def subcommands()
          {}
        end

        def run()
          @parser = parser()
          @arguments = parser.parse(@arguments)

          return help() if not @command

          command_class = @subcommands[@command.to_sym]
          return error("The command #{@command} does not exist") if not command_class

          command_class.new(@subarguments).run()
        end

        def split_arguments(arguments)
          main_arguments = []
          command = nil
          sub_arguments = []

          arguments.each_index do |i|
            if !arguments[i].start_with?("-")
              main_arguments = arguments[0, i]
              command = arguments[i]
              sub_arguments = arguments[i + 1, arguments.length - i + 1]

              break
            end
          end

          return [main_arguments, command, sub_arguments]
        end
      end
    end
  end
end
