require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ldap < AbstractPhp72Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.2.34-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "22f612910ecc0bd719744a035b2feef15cffd604abb57dd8a432b765edeafe77"
    sha256 cellar: :any_skip_relocation, ventura:       "2d1552cadfaf9689aeab03bb368509e400559034c3c2902a0200247b6863ce53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "388153684edab443a59088e8d228f61f1b1e9e0fa83e8861455ecfa0cafada25"
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
