require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Intl < AbstractPhp71Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a367ca960d2cdd68d6811c2f3c83fc738939adfbd42676b07471f903a02d38a6"
    sha256 cellar: :any_skip_relocation, monterey:       "5c9e7ef6aea44d4c4e9069a728bf203a0df31f9c2e699c46b17d2bc7408b42fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bb325324f5b82ec430d9d7600b745953324170a96a1aeae7377a3f363544635e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "c9eb438a87943d0f0394c77fd1f01e6df1bb62a4cbeea8d57e7dbeb7ffd9bfc1"
  end

  depends_on "digitalspacestdio/common/icu4c@69.1"

  def install
    # Required due to icu4c dependency
    ENV.cxx11

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
