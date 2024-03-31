require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Ldap < AbstractPhp83Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3caf18b82d7c5d38796b07e2ec4e33735c2cc6092a05a76bed12e9759caddd50"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bac66a77d897af4b637e85bd9e5370592cf2cc55b2063dd7827ec296a86bb5d4"
    sha256 cellar: :any_skip_relocation, sonoma:        "b5689db194172c0a8f6644faf3b79172f6a9af67b413e55115500283ae2128fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7dfdd040ac9da267c1c93deb6f27e6bcb69ef592d544a50b687112307bf0b46"
  end

  depends_on "openldap"

  def install
    Dir.chdir "ext/ldap"
    headers_path = "=#{MacOS.sdk_path_if_needed}/usr"
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-ldap=#{Formula["openldap"].opt_prefix}",
                          "--with-ldap-sasl#{headers_path}"
    system "make"
    prefix.install "modules/ldap.so"
    write_config_file if build.with? "config-file"
  end
end
