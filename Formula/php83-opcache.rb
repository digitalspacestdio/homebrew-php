require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "afa2f4bdbaaf8f7159e2fa69d334f075ed2caa076787ba5d169661dc51bd6ff8"
    sha256 cellar: :any_skip_relocation, monterey:       "17124a78b261b176a63b6b34b2c811017b8038c3366a0a27544187b93b9b3ced"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66a7cdd5c0b3792c8d51473cef596fe5b28f5be510bf70f24bc84053a089207c"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f848783554ab2671463fa097f4a41334c12f750ce5c427d5c4d0859b58625fe0"
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
