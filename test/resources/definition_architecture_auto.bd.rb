
name "erlang"
version "R15B03"
maintainer "Nu Echo (Matthieu Vachon)"

source do
  from "http://www.erlang.org/download/otp_src_R15B03-1.tar.gz"
end

package "erlang" do
  architecture :auto

  provides "erlang"

  depends "libc.so6"
end
