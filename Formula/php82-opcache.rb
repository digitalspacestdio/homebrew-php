require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Opcache < AbstractPhp82Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d8b607bf7039590c6765349f8e5c1fc71b2171f70b662a488e7cd8ff022ce122"
    sha256 cellar: :any_skip_relocation, monterey:       "8f5a098cde3b94adb45e452b15dfb7bc57f3ca3183b969a864e5136fee344d88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4367c8e5a70efe0f991d91a5a9d3ccad818442ddc611146b9de65cca279811f1"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a5d5110ba520d0306841e493b3da6b48229c1a097365c7350bcb019e4eebe953"
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
