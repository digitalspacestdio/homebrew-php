require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Intl < AbstractPhp72Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0b0b083da12f8564114cad5a400e5a3cb893234ff0e514177162d13d91b5da12"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "71c6f483653fce71945053a218b43afa197886f81cc2d415c529bc3bdaa6c9df"
    sha256 cellar: :any_skip_relocation, monterey:       "a210eba0b85e8b349efd3b945866edacc0ebc13e80dafe6c9777e057a109b846"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7fc531e1c44b84be7b893237e672c763a6a7339997279ff429ac5ad1c7486fa7"
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
