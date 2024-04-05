require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Intl < AbstractPhp83Extension
  init PHP_VERSION, false
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f10055c7a3c3b19e13b69405666d160d2b59483148c5700dba735962402ced8a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "948e4d0dcb3a493ea953c6cfd639436f593b68d9782a61c9a4bcd2a434de75f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "b595e74cd7e4833ba6641bea2d2b1ffe016623e2b3c9db3ff69def362b3bede8"
    sha256 cellar: :any_skip_relocation, monterey:      "b078fff7bdef88ad9811603f1ce78b42e604303e4141cf6f8bc6c4a6bd1c649e"
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
