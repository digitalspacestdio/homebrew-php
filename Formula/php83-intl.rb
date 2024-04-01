require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Intl < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8865bc546b6fb852650107777508073f73942c1163625a5de4fd233353b8a1bb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c7b6c71f3cdaf5bb9d7c8af413e9167539b24f1d24768c8a5735d383d74fefcb"
    sha256 cellar: :any_skip_relocation, sonoma:        "75843f7f838aeb5cec8615bc0b05df2b721f4e4a63b21e9177abb2e7ae558cc4"
    sha256 cellar: :any_skip_relocation, monterey:      "c1db27ab61dacf0cd29448e03d4f14d2b34fd0efdc269476190708114678981a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d226a22909e3194f5cbacd4c6bd4f826c57e490ba92259047b4e5662d8854593"
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
