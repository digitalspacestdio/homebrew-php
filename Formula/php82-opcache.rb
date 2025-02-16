require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Opcache < AbstractPhp82Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c87c64f60134b409c264c0b6364496a7b7f8fa4bec052bdb0b4f709176e845e6"
    sha256 cellar: :any_skip_relocation, ventura:       "15985cc9b2ebc20c8174a5bd47c0a4986932ffc49d89a54c2c3001a6296e16cc"
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
