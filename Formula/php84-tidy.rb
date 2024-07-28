require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Tidy < AbstractPhp84Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0-100"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f5ed7c8a1fbc7794bd08616267028c4c7d082d56db5450e50ac910352a229d64"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "b58601850546924ae455640e8f1696e3fdc2d6941ef9dfab35866f0145b611c3"
  end

  depends_on "tidy-html5"
  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
