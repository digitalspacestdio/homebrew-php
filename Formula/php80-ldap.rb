require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Ldap < AbstractPhp80Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 26


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "df03ca6f00824077e6000ceadefd2b924da7ddbb96a35c7664a6f76239c9a6bb"
    sha256 cellar: :any_skip_relocation, ventura:       "43a0db7dffe9f8f75bc92c067c4dcc0571d2f31fa0466ee451025e93cbfeff32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0cf6f72fdf0ca6670387f36a2b488f715054e4cf37675b1d0851dca599989a27"
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
