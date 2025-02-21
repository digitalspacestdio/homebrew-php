require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Opcache < AbstractPhp82Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.27-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ee44558c3a93e4afb0f1aa872455363765cb71c45f865e1c0e710751f745f09f"
    sha256 cellar: :any_skip_relocation, ventura:       "0014f034c1141e711978e253e8663d44f0c541fbd98d8e294bb47e288ad22f56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ecf7f2e4c1307f2b4fcf3a53def728b4de7feadbd7c4e736fbc51e4f922a609"
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
