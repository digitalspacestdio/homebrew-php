require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Intl < AbstractPhp82Extension
  init
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision 2


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0446d2b854abd35bfa182bfc1edfcc23debbecbd262efe3ba5aa994c8e5d2b78"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8cb888ade93b1b67a79323d5ddeda17459a33a2c91fb8487bb5bf447dc73fa1"
  end

  depends_on "digitalspacestdio/common/icu4c@72.1"
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
                          "--with-icu-dir=#{Formula["digitalspacestdio/common/icu4c@72.1"].opt_prefix}"
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
