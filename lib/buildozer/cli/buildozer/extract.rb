require 'buildozer'
require 'buildozer/cli/core/base'
require 'buildozer/task/extract'

module Buildozer
  module Cli
    module Buildozer
      class Extract < Core::Base
        def usage()
          "Usage: buildozer #{name()} (options) <definition> [<definition> ...]"
        end

        def description()
          <<-EOD
            This command will extract the source archive that is needed
            to construct the various packages defined in the definition.

            If the source archive has not been fetched already, this
            command will do so.
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

            extract(::Buildozer.load(definition_path))
          end
        end

        def extract(definition)
          Task::Extract.new(definition).execute()
        end
      end
    end
  end
end
