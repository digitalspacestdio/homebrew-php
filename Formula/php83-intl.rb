require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Intl < AbstractPhp83Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.17-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "115d89df921c28ff0bfc432f8c6d69d08fc403b5c8905a88640ef478f10952cc"
    sha256 cellar: :any_skip_relocation, ventura:       "a7dc7c35e32d8abe3cda24017b98e8162c1396be5cf47b108ff790b0bf0968ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "76dc5e209b92346b15b5a554265521261a3794dc041937dc93bc0b6a44a5c228"
  end

  depends_on "digitalspacestdio/common/icu4c@74.2"
  depends_on "pkg-config" => :build

  def install
    # Required due to icu4c dependency
    ENV.cxx11

    # icu4c 61.1 compatability
    #ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl",
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix}"
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
