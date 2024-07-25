require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Intl < AbstractPhp82Extension
  init PHP_VERSION, false
  desc "Wrapper for the ICU library"
  homepage "https://php.net/manual/en/book.intl.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a7c2b64984ff29e4d1c7a75bc5ba1bbd6976fd6364d66359a2ff887b940bcb68"
    sha256 cellar: :any_skip_relocation, monterey:       "25e3b36651bf03cd0396a9e1e2587b48b4f7c548f82daa4c590c46096642824b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "416f89b22d974814bab10d80acb7d7a8a03c397269ba0e66353725d00f416800"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "8eea1825fb34846881ecf0c4984a8bcd60bef60faa6efb1611a819b4fc2046eb"
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
