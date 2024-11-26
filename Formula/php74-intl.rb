require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Intl < AbstractPhp74Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b86c8e97ddc7f3afc654009b3964767c828d842ab19a31d51124ec8a0c325a1b"
    sha256 cellar: :any_skip_relocation, monterey:       "6c41bd1b384dc51426f17ea03c859c31db7e89f2272dfeefe1bd5b3c9788a431"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7b753348d06307137cf488b57a7534bf535a5672151ca943bd777db53b317f75"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "2d7a5a76e4a33337332ae7215ea8fac314384e781f3172d72193c655dcc4aa3d"
  end

  depends_on "digitalspacestdio/common/icu4c@74.2"
  depends_on "pkg-config" => :build

  def install
    # icu4c 61.1 compatability
    ENV.append "CPPFLAGS", "-DU_USING_ICU_NAMESPACE=1"
    ENV.append "LDFLAGS", "-L#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix}/include"
    
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
