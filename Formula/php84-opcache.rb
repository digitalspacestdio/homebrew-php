require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Opcache < AbstractPhp84Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "52c2e3c28ccd3d51c56fdac47f63da71b1c900285065f1ac82548bae3d0fc9e3"
    sha256 cellar: :any_skip_relocation, ventura:       "45c87b50cb5cc8f46ebeed7afcbf178e55f75f6786b22b868f0ffe0abcd831b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cdd8d8f132abeb660af987fb8ef36a5f048a5fa270ebfa777770fdaa65f2a99c"
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
