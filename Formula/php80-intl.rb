require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Intl < AbstractPhp80Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1604a4de8f2737aa2f30a19e805b4a17d1382fa8cace662bb2788e32f890f643"
    sha256 cellar: :any_skip_relocation, monterey:       "4f427c3e3d852aa9b9d496d7f4581d8730f24147ac2b841d176ff8891849e695"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf6071e53fe34b73c50f8484510512107ffc2d7cfbe089ce4a5dfe6fa6499915"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f3e90d4e45c5c4603024fa32dea56504b4e71f2983f08dc2207053492a973f31"
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
