require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Opcache < AbstractPhp73Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "de5677991bd2079ceeb971d4d53b0a4e70f04711546c91ddf6794635edbea2c9"
    sha256 cellar: :any_skip_relocation, ventura:       "84c9432fd9ebf2f73defe7b09278555581da54809ba9f5f5aae782e248e182d5"
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
