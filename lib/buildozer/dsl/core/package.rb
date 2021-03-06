require 'buildozer/dsl/core/fragment'

module Buildozer
  module Dsl
    module Core
      class Package < Fragment
        def initialize(name, &block)
          @name = name

          @architecture = :auto

          @provides = []
          @depends = []
          @includes = []

          if block_given?
            instance_eval(&block)
          end
        end

        def url(url)
          @url = url
        end

        def version(version)
          @version = version
        end

        def archive(archive)
          @archive = archive
        end

        def maintainer(maintainer)
          @maintainer = maintainer
        end

        def architecture(architecture)
          @architecture = architecture
        end

        def depends(package)
          @depends << package
        end

        def provides(package)
          @provides << package
        end

        def includes(entry)
          @includes << entry
        end

        def type()
          return :package
        end
      end
    end
  end
end
