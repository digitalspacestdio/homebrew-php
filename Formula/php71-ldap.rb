require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ldap < AbstractPhp71Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 26


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "31b27571f6868e789ba7dbacd867119f8e8a90847af22845a076f471b050fe65"
    sha256 cellar: :any_skip_relocation, sonoma:        "b5dc1987346e2c73c238563b109300a327278afd6ba9856abd1fc6cf83fa08c4"
    sha256 cellar: :any_skip_relocation, ventura:       "72bf9186ee41abc02a93ddf5860ec8a28bd8d048fa53ff6a035200c49c8d4ccb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f723ae835665baec36587aa8970869285e678d189b58b54c8ba38609336e6ce"
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
