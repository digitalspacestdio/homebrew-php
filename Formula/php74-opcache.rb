require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Opcache < AbstractPhp74Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0bf6812f9f609bd2396109456dc4ee1d8d5a65117cb247c7b36d7f9b76ed4ed7"
    sha256 cellar: :any_skip_relocation, ventura:       "6500d9616ae5a00ef6d4ee4a9efaf8ad5f30fe51b08184b89c5894c4c3ff38b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b6c6d993ec2ab9f5e8e9321219e9a280947e5653e15c5332a0a8f0c3ea4e4df"
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
