require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Intl < AbstractPhp72Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2278e519c40a30ce760c3550fc2d56c9ce636f45526761a141e81528fc72c556"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "aefdc6908272941e19569c09270794c2cfd2f9b6d43fa2164d1758aaaca251a2"
    sha256 cellar: :any_skip_relocation, sonoma:        "8446739c302c831de44ae5da0480f0e73112bc307b712d2f92b4b8ea08c983cb"
    sha256 cellar: :any_skip_relocation, monterey:      "1b1fbca32709dab7ca12577a96c9c9ea51cf29355e9ce6fa4a74d519e7717533"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8aad9ec8d6fc13b2ea3cca881d19fa02b0923dda863ad84fecf94ecaedce2132"
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
