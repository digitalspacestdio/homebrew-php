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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0740c7be1a27d4201f10147eef6e5d501f7b09951915a61cd6f86091dc136a7f"
    sha256 cellar: :any_skip_relocation, sonoma:        "bf4c959972923d40803255a8556eabbc871ce9cb61c24498371e323a4a7f4dee"
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
