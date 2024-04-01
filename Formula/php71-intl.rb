require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Intl < AbstractPhp71Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a9f0cdc12fb0e6d3f6866784883809fd1a533b2c00745d844cfcfa3af68c42e3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "55e0c3efe08572d1435055d316bc775851796729f56d5e9461974470fb6c86da"
    sha256 cellar: :any_skip_relocation, sonoma:        "e72bf3e1afb005ef02a88346be7c0670b87da9c0c843a6585dabb3924c83a7d1"
    sha256 cellar: :any_skip_relocation, monterey:      "2405b27455b56fffbfebd49c416f471334f0c53bbc945bd514689a61277ac9a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "66d7892958fe23c0bf5d0eacd131f2562f1e9a811d27ac122902992e553243b1"
  end

  depends_on "digitalspacestdio/common/icu4c@69.1"

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
