require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ldap < AbstractPhp72Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "88633df6dd91673b4620c99604011a26b9bbb529d7200e0ec6218ead2efccf50"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ca9da776cde5b1794c7e42d0ed0d4996367c21139cd8cc14d9170712cdc062cc"
    sha256 cellar: :any_skip_relocation, sonoma:        "28ce415a5e106b140df9a5890e27de6c624fb9954256b2eb9709b0e708fcf479"
    sha256 cellar: :any_skip_relocation, ventura:       "c205bde4b7e8eedc415e9e434cd4cc22e290d6f5b6bafa129ffda6a02e962a23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8745d70a4fddd1ccbde481aa34a69274de84af317f23c368c1b8c74fc887f12d"
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
