module Buildozer
  module Dsl
    module Compiler
      class InvalidDslFragment < StandardError
      end

      class InvalidDslDefinition < InvalidDslFragment
      end

      class InvalidDslPackage < InvalidDslFragment
      end
    end
  end
end
