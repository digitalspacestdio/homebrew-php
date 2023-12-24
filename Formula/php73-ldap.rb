require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Ldap < AbstractPhp73Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 26


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6498aa2e34e4f9153363d288d620f89c6d7598bab6b699d3b5eee6bd3dddf57b"
    sha256 cellar: :any_skip_relocation, ventura:       "14d20ddbf9b61f4d6fc34a673015893c4114f1e436e4a6dfe6f82ce9fdc2aef9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f561b144ad0d9da74d78b8c85d7e9b46fd670b766ed6d7185fbb5f9d54696da7"
  end

  depends_on "openldap"

  def install
    Dir.chdir "ext/ldap"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-ldap=#{Formula["openldap"].opt_prefix}"
    system "make"
    prefix.install "modules/ldap.so"
    write_config_file if build.with? "config-file"
  end
end
