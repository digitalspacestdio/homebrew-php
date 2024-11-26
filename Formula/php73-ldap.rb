require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Ldap < AbstractPhp73Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5ab472f3d10a2dfcd032b00035b4e8b821556b16a4425fd2a705eab5d5a662fa"
    sha256 cellar: :any_skip_relocation, monterey:       "593a82bbc01f487b7cb6c444a037aff078fb1ef320e61d056b30fb0e0acd90e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3188f4d067fe0a5b810c58ea30c3e2c6f0d9bf42613efa14104aad7813dec11f"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "df3203c839358bacb21fee6e8615297a41490e012927199d458e0fd60ed8221e"
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
