require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ldap < AbstractPhp72Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 26


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "997e0126999bf0c5e55ea77c3e0b6ce754fa9b84f6167017c8c021ea8472a587"
    sha256 cellar: :any_skip_relocation, ventura:       "c205bde4b7e8eedc415e9e434cd4cc22e290d6f5b6bafa129ffda6a02e962a23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd2e012b4f4a49087eeb35dfa6e7b53dba3054452cc5fc2501c60a6e4efe92ba"
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
