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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "80782c796491155d0a68e447265f46a7aa5ee974ecb4bcae0cbf251c42421dcf"
    sha256 cellar: :any_skip_relocation, sonoma:        "470d06bd2889929744d3a1d2b4a7b074f84592d084c491952fc4479313927631"
    sha256 cellar: :any_skip_relocation, monterey:      "1b1fbca32709dab7ca12577a96c9c9ea51cf29355e9ce6fa4a74d519e7717533"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0329f22e3ccf63f5f386a5859346959f99c35974defc48afc65c09d0f78564f6"
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
