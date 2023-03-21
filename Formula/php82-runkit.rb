require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Runkit < AbstractPhp82Extension
  init
  desc "Runkit extension"
  homepage "https://github.com/runkit7/runkit7"
  url "https://github.com/runkit7/runkit7/archive/4.0.0a6.tar.gz"
  sha256 "b692faeb45553b5abfb167ae94a843a358bb90a578095fb24cff911ac3ca5425"
  head "https://github.com/runkit7/runkit7"
  version "4.0.0a6"
  revision 1


  depends_on "libtool" => :build

  def install
    Dir.chdir "runkit7-4.0.0a6"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file if build.with? "config-file"
  end
end
