require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ldap < AbstractPhp70Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 26


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1238e6a3b1a8a8e67273054ea3ba04174b70110a26aa9cb1465591451e8d8265"
    sha256 cellar: :any_skip_relocation, sonoma:        "46151c81d39680da44228123130018ef4234368b2a438fada390c7e5fd595c73"
    sha256 cellar: :any_skip_relocation, ventura:       "301dbd32ac18c3fb72e5dbfabd6cc5bcf6acc3de3f6677ff4d7c1507cfc88596"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7193232cd79c1823a4d7a63dba455cb0db5476305df96e16eb12ad0816196f7b"
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
