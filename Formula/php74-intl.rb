require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Intl < AbstractPhp74Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d362ad58ace3bcc6803866458141d9f8db198e5ad5cfaa6accade365c2eff220"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5548c26d380584d32835f898e1d2f62b6b3d96502a98bead5003a4e100d49df5"
    sha256 cellar: :any_skip_relocation, monterey:       "5f7361bbe426b7a6dc671f572f281154c4a5cac274e1e0366a8c242acc9a0ca7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "806f26ca9ea2cd2bb94dc6ee0669c636c400235760b2cf5158bac15a79ac5fa0"
  end

  depends_on "digitalspacestdio/common/icu4c@73.2"
  depends_on "pkg-config" => :build

  def install
    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/icu4c@73.2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/icu4c@73.2"].opt_prefix}/include"
    
    Dir.chdir "ext/intl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--enable-intl"
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
