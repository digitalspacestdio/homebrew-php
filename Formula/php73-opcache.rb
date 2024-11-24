require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Opcache < AbstractPhp73Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fb53f44cf9916d81d82d8eb7d7dc28c3468164078dec5485acda82a13ef0a3ae"
    sha256 cellar: :any_skip_relocation, monterey:       "d5d6ccfdd61cee66fd21d6c1d9c620868d7ebab53d2f1c9867e0ecea220e6c30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dd0dbb2959943f69da60a8b3db4072391527d00db475f45db0b715750676d7b9"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "92a685e0bb7e90d8ae9bc11fb18f66377e378bf7b3db88848e308a97402f50f7"
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
