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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5490960eacc44c297ec623d92afd820d18faf924593b15d33ac20fb8e1fc593b"
    sha256 cellar: :any_skip_relocation, ventura:       "11cef29747c25891a5ec4cc0263977254918a1635919b7fb964394e1d5e7bad8"
    sha256 cellar: :any_skip_relocation, monterey:      "8f2c255b19986e4b31a675ece0d47aa35b0e912f1ca275860804688726dd756e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10ce006f80ddde82ba24f19c9fdca18d8221186fee14af3a5a9210fd7e0d26ee"
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
