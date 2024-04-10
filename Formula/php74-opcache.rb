require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Opcache < AbstractPhp74Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7ef594451e2c5a286810a47e5e51c0a7054d75ebc50bc14ae7fc22a156d48c6a"
    sha256 cellar: :any_skip_relocation, monterey:      "539ceddc86d2bc88b02d17da801b89030e98eae5d2a768d693f1fc37fb57614b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5608735e7829f82a26bcc75f5515fcb1a04390a08e3faab9b716fad975542738"
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
