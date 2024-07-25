require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Intl < AbstractPhp74Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4ec8838da00a29ff16f0985cda9c56fd0b6287396b5b28a885986d0bb80cf290"
    sha256 cellar: :any_skip_relocation, monterey:       "97fbdec9a0011ba98248230f223cfbd4397249530ef15bc1f6f81acf1ecb677f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f652a70dc42146a9867e312922d245a8966e7799162f308b637aa65fa35ce7d5"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "410ad80860353f5ba6da989018a6e1b00ffa0420fb833d14e0c58ce2bc2a00a4"
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
