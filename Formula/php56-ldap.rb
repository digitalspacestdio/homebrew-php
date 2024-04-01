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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c39e25279b5e8ffdc9cedb433700c0c163d3dde971fafac0d4bbf04e9761c065"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b418dd4bec9a97fdadf8c0f9691a6908936dfcf0bd2c6f0319bdc9fe1fc22363"
    sha256 cellar: :any_skip_relocation, sonoma:        "c9afd7c5152c3bf463011a53ff6440782d2134f12773ecdeec46cabba538f695"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3eb4dbb273b0ae2ab4fb9101f0914545aa93bd462e74ea277863d535f193560c"
  end

  depends_on "openldap"

  def install
    Dir.chdir "ext/ldap"
    safe_phpize
    if OS.mac?
      ENV["SASL_CFLAGS"] = "-I#{MacOS.sdk_path_if_needed}/usr/include/sasl"
      ENV["SASL_LIBS"] = "-lsasl2"
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
