require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Runkit < AbstractPhp80Extension
  init
  desc "Runkit extension"
  homepage "https://github.com/runkit7/runkit7"
  url "https://github.com/runkit7/runkit7/archive/4.0.0a3.tar.gz"
  sha256 "ead22e46715e96f4982c015ad74a85bf76babdeb23c41adbe2220d0d2de8256d"
  head "https://github.com/runkit7/runkit7"
  version "4.0.0a3"
  revision 1


  depends_on "libtool" => :build

  def install
    Dir.chdir "runkit7-4.0.0a2"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file if build.with? "config-file"
  end
end
