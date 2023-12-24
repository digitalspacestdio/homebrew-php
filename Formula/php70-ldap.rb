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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "043671cbbec8f527d8926be1cfa06a14a240d6416064ca214a34d16ef0a0119e"
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
