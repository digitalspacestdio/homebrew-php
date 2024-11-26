require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Intl < AbstractPhp84Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2f77ba843f708f20bb48179527432ee1f3372743bcc425fbc7944aa460c01bf5"
    sha256 cellar: :any_skip_relocation, ventura:       "1bcd2cd87db83c430077782b3f0887341c073d548472d619592caa9658fb6795"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "af696336a73c69a33ba13a12e113b7db3572f805e62fc47ece1460f1f36cfd76"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "edbcc9341b9e330674beafbc1ce397739c3cb86c22b4e76b6b0606eeebf6e265"
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
