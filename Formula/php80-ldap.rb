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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2722f92c3b08ef352454d306c37c4a17b3a0158dc4f687d4ee205f49c1c464ed"
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
