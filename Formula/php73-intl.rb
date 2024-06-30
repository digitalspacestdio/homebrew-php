require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Intl < AbstractPhp73Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c22d27fb9fe1c2bab0e93beb0c5c3014cfff870a33bddbd1eacb5efa7b7408d0"
    sha256 cellar: :any_skip_relocation, monterey:       "ca6e2c049593734cd809de7c9e684563bab668566e97ec7f707df9675053e998"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "302970a06496f86db6a6ed73e5cc4df34e224f24c3d4112e714917c8dc2cd1d0"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "9b9a5f7483bfbbe00534404cb29b991100515a48660151490e1845c6c20aaee7"
  end

  depends_on "digitalspacestdio/common/icu4c@69.1"
  depends_on "pkg-config" => :build

  def install
    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix}"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS

      ;intl.default_locale =
      ; This directive allows you to produce PHP errors when some error
      ; happens within intl functions. The value is the level of the error produced.
      ; Default is 0, which does not produce any errors.
      ;intl.error_level = E_WARNING
    EOS
  end
end
