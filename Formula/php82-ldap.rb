require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Ldap < AbstractPhp82Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.26-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "21cd3f6197af7d09e6cd8fe718dbb05a08741dce050783988300f8ad9283ba8d"
    sha256 cellar: :any_skip_relocation, ventura:       "9290cc90e605c897bc27a872dcf6b57ad51b9d7c25df9fe3ecec798ae917381e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "85dae679b0212cd1739ce63900d62f80b313dbe2c595cc03ddb98b290c708fe3"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "62d8b29dacc386b48549ec05ee02b98b8bcc8ff4f9710088c3aaa6e7c07246dd"
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
