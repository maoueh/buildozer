module Buildozer
  module Package
    class Builder
      def initialize(package)

      end

      def command
        buffer = StringIO.new

        buffer << "fpm -s dir -t rpm -n #{@name} -v #{@version} -C #{install_path} -p \"#{@rpm}\""
        buffer << " -m \"Nu Echo (Matthieu Vachon)\""

        @provides.each do |provide|
          buffer << " --provides \"#{provide}\""
        end

        @dependencies.each do |dependency|
          buffer << " -d \"#{dependency}\""
        end

        if @ldconfig
          buffer << " -d \"/sbin/ldconfig\""

          buffer << " --after-install \"/sbin/ldconfig\""
          buffer << " --after-remove \"/sbin/ldconfig\""
        end

        @directories.each do |directory|
          buffer << " #{directory}"
        end

        return buffer.string
      end
    end
  end
end
