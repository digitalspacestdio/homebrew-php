require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Ldap < AbstractPhp74Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7ddff74a9267e0e9a53a091e31c8037451d2da7eba76040dce3ffce420112236"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1f3a80879f2028100703c4f6a6f62f67fb7092020a95653e7a46a2eb3c2558cd"
    sha256 cellar: :any_skip_relocation, sonoma:        "eb684a921a2f15bceba8dc1e27ec7221a06d50a812a4fa968709bcbbffa61ae8"
    sha256 cellar: :any_skip_relocation, ventura:       "29c733c3c972101d48b84c3de4b32e3cd91fd518ff2343e30c175ae820db948a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e8233cf29b0394946b741c55f8c9bc37330afffae196ba8d9b488b88d504f3f"
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
