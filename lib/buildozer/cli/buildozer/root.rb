require 'buildozer/cli/buildozer/build'
require 'buildozer/cli/buildozer/package'
require 'buildozer/cli/core/composite'
require 'buildozer/version'

module Buildozer
  module Cli
    module Buildozer
      class Root < Core::Composite
        def name()
          "buildozer"
        end
        
        def subcommands()
          {
            :build => Cli::Buildozer::Build,
            :package => Cli::Buildozer::Package
          }
        end
        
        def options(parser)
          super(parser)
          parser.on_tail("-v", "--version", "Show version") do
            version()
          end
        end
        
        def version()
          puts ::Buildozer::VERSION
          exit(0)
        end
      end
    end
  end
end
