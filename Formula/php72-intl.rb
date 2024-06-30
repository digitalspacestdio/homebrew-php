require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Intl < AbstractPhp72Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "88b0fbbf2f991ec768a6079a2bac0ecc2e76c9b49db11958ccd564e73d90ae38"
    sha256 cellar: :any_skip_relocation, monterey:       "76cdf3d31d2b07d08adf051f7352e42337137f4c299083f0fc08f0ede1c1885c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aa2cad00a9e0ccc0febaa68d7df3d3de30179b3568f4918ff4ecd0d8ae204905"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "51b313a73f6ea303ccdabae7e8a890ecc5d2fd294c11149f99afd571ab7943e5"
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
