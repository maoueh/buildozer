# Buildozer package definition for Erlang
#  Architecture: x86
#  Platform: CentOS 5.9

package "erlang" do
  url "http://www.erlang.org/download/otp_src_R15B03-1.tar.gz"
  version "R15B03"
  maintainer "Nu Echo (Matthieu Vachon)"

  architecture "i989"

  provides "erlang"

  depends "libc.so6"

  includes "usr/bin"
end
