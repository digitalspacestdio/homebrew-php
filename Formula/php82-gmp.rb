require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fcb267248b858d98269643eefbc3cbe4a2acf2f7c9768c169f08417bdcd096de"
    sha256 cellar: :any_skip_relocation, sonoma:        "31d840a79a9027c589d265422427975b36fbfa9ca5c3425e4912c4c78ad1b6d1"
    sha256 cellar: :any_skip_relocation, monterey:      "2985358837129eedba3ce15fbca6cdadc8eb154fe6e6f05444d8a75dafeb8e64"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "42c636fea9a33f3920f83fc10ed18494eeb3037164e61ec78df1add79cdb9469"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
