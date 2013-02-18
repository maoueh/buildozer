require 'buildozer'

descriptor = Buildozer.load(ARGV.shift)
puts descriptor
puts descriptor.instance_variables
