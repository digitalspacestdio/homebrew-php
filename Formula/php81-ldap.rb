require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Ldap < AbstractPhp81Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "21fe111d171933d8ceefb3fa91e050081fc3994776fd31deb5804a3e9cc3e068"
    sha256 cellar: :any_skip_relocation, ventura:       "117ae885e26dfb445bbc0081115300a678888f7883d11965c29e03879609421c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ec817bd3dab17c04168f442ce23bea3ee7d802b58ff118621289d2d7a6ef4cc3"
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
