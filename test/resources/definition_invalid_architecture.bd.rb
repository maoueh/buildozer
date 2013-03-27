
package "erlang" do
  url "http://www.erlang.org/download/otp_src_R15B03-1.tar.gz"
  version "R15B03"
  maintainer "Nu Echo (Matthieu Vachon)"
  architecture 15

  provides "erlang"

  depends "libc.so6"
end
