module Buildozer
  module Dsl
    module Core
      class Fragment
        def options()
          return Hash[instance_variables.map { |name| [name_to_key(name), instance_variable_get(name)] } ]
        end

        :private

        def name_to_key(name)
          name = name.to_s

          # Remove first char of instance name, i.e. the @ sign
          return name.slice(1, name.length).to_sym
        end
      end
    end
  end
end
