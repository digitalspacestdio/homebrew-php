require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Opcache < AbstractPhp56Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a8bc1a69200f0004ffb616cfd82ade9dac1d4d76587563f28a8fc2caea181700"
    sha256 cellar: :any_skip_relocation, sonoma:        "425631e76e1f07799e5f8edea4505aaf0e061cdc080d862708147ffce1617fc2"
    sha256 cellar: :any_skip_relocation, monterey:      "0069dd2908ded2e32a63964f7b055510084f9cb7b6f32945639ef0b96de5cdfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d713742c0d71fee611458345bc6a3a02c854daeb03c2263de5919e616169baf"
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
