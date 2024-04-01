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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b0463fa60fc9d70fb83ef9c1fb7485797c82bf9447165a8a9ca0fe57bb57e608"
    sha256 cellar: :any_skip_relocation, sonoma:       "47cecc252209394b7a4a12b3d34a0b68bce0e43375a6f93e0a66ae701f1d67bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4bc8b90b2407fe413f1e9a819c75c78256c94e8326ba44976d10a0847984e004"
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
