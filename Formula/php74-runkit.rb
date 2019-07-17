require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Runkit < AbstractPhp74Extension
  init
  desc "Runkit extension"
  homepage "https://github.com/runkit7/runkit7"
  url "https://github.com/runkit7/runkit7/releases/download/2.1.0/runkit7-2.1.0.tgz"
  sha256 "64644eaa171f3a9b5c69fa85a11c4f7061331dfd9425eed57a9d728bfb52b0dd"
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
