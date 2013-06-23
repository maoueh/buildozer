module Buildozer
  module Dsl
    class InvalidDslFragment < StandardError
    end

    class InvalidDslDefinition < InvalidDslFragment
    end

    class InvalidDslSource < InvalidDslFragment
    end

    class InvalidDslPackage < InvalidDslFragment
    end
  end
end
