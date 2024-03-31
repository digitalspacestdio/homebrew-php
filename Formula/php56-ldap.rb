require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ldap < AbstractPhp56Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4e116f34a6d8f3980a0900cdd5144a71655a1185b0ad09c588ff324a31349cae"
    sha256 cellar: :any_skip_relocation, ventura:       "e97147f98631ecc7a3c50edf81a0ee44d7833ac3943ffcd6ff334379d4b8f030"
  end

  depends_on "openldap"

  def install
    Dir.chdir "ext/ldap"
    safe_phpize
    if OS.mac?
      headers_path = "=#{MacOS.sdk_path_if_needed}/usr"
      system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-ldap=#{Formula["openldap"].opt_prefix}",
                          "--with-ldap-sasl#{headers_path}"
    else
      system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-ldap=#{Formula["openldap"].opt_prefix}"
    end
    system "make"
    prefix.install "modules/ldap.so"
    write_config_file if build.with? "config-file"
  end
end
