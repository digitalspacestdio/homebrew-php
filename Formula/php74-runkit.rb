require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Runkit < AbstractPhp74Extension
  init
  desc "Runkit extension"
  homepage "https://github.com/runkit7/runkit7"
  url "https://github.com/runkit7/runkit7/releases/download/1.0.9/runkit-1.0.9.tgz"
  sha256 "9d83e3c977d6dcc0c1182b82c901936aace2ba6a4716bb9021ff86725285771a"
  head "https://github.com/runkit7/runkit7"
  revision 1


  depends_on "libtool" => :build

  def install
    Dir.chdir "runkit-1.0.9"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file if build.with? "config-file"
  end
end
