require 'buildozer'
require 'buildozer/cli/core/base'
require 'buildozer/task/fetch'

module Buildozer
  module Cli
    module Buildozer
      class Fetch < Core::Base
        def usage()
          "Usage: buildozer #{name()} (options) <definition> [<definition> ...]"
        end

        def description()
          <<-EOD
            This command will fetch the source archive that is needed
            to construct the various packages defined in the definition.
          EOD
        end

        def execute()
          if @arguments.empty?()
            error("You must provide at least one definition file")
          end

          @arguments.each do |definition_path|
            if not File::exist?(definition_path)
              puts "Definition #{definition_path} does not exist, skipping"
              next
            end

            fetch(::Buildozer.load(definition_path))
          end
        end

        def fetch(definition)
          Task::Fetch.new(definition).execute()
        end
      end
    end
  end
end
