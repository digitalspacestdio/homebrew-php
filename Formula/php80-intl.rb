require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Intl < AbstractPhp80Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "228b547633cfa2507a366b48be82f5e773a5ba9ec3d2ab14a60104ab2e0ff724"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "39bac939a07b8cad33feda6cd51410819058b50561312ea61b9a88ea2673c4bb"
    sha256 cellar: :any_skip_relocation, sonoma:        "fa3322e0521e597f04db6efa9fb3f1382f70ec4c78894f5264c2ce86c1585d5a"
    sha256 cellar: :any_skip_relocation, ventura:       "81455a7c5f1a006936d79cf0ef53fa1d17da49dee3a20717b7cb1428f582d437"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "446519ab049b7181823957a027025eb3f30775e6bf152957ea2fa4510c1f49d4"
  end

  depends_on "digitalspacestdio/common/icu4c@74.2"
  depends_on "pkg-config" => :build

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
