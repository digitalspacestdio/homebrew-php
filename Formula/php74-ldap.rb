require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Ldap < AbstractPhp74Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 26


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "08c535955e1f68c749858419bf59a30dc517218431b936eacf41ee1fa0053761"
    sha256 cellar: :any_skip_relocation, ventura:       "29c733c3c972101d48b84c3de4b32e3cd91fd518ff2343e30c175ae820db948a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "795a537230dff8c1d8f79ad1b3d0191c9f91121e1533ea8b09540585f7c51815"
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
