require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Intl < AbstractPhp73Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1363fd502592ae81ded782facbfd4e1b7b2130d1ac1d28cf3f071e9be317a00a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e769b09ce527d7ec1f522f2a081c5d2a8d16050619ee5e6d35231c9ce366470d"
    sha256 cellar: :any_skip_relocation, sonoma:        "df0dfb996fb5673fda9bf981b5e33ae88126e86d09815ff91167f736098251da"
    sha256 cellar: :any_skip_relocation, monterey:      "6d7ff6ed5b8ad114deab12cf32f391b671384aaa192c37dfd6095672636be2b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c9a17db088e35352067afc96a18dad4aa8089f4994f9d270468f5917295379c"
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
