# Buildozer package definition for Erlang
#  Architecture: x86
#  Platform: CentOS 5.9

name "libogg"
version "1.3.1"
maintainer "Matthieu Vachon"

source do
  url "http://downloads.xiph.org/releases/ogg/libogg-1.3.1.tar.gz"
end

package "libogg" do
  provides "libogg"

  depends "libc.so.6"

  includes "usr/local/lib"
  includes "usr/local/share"
end
