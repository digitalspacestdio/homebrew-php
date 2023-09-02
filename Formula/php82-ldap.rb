require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Ldap < AbstractPhp82Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "333b4efc844c52cfe190438c4dbfa85e16dc0e9a48d1c969c059c8376ca7f21f"
    sha256 cellar: :any_skip_relocation, ventura:       "9b19545e17805b508393d6a50cb72297240088af648ea0336d91101c94673814"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "271d784000543ba7556b6d46a7501c56130a2870d576c385dd00482cdf871584"
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
