require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b9e04a48283d320127ad5424de5959c196901041e468140e3464ce1fce0d9109"
    sha256 cellar: :any_skip_relocation, monterey:       "677d12884a88e3f4ba752c3894944595b59e2814b121386a33e65e86505f5393"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bbb61d081241d03986aeb484f7692cdf544689097709d6c7913a89254ef12394"
  end

  depends_on "pcre2"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
