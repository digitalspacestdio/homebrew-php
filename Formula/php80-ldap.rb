require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Ldap < AbstractPhp80Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "069a590742421f43f3cef95cae9f6e365964633c59936cb0dba2219d7b44f898"
    sha256 cellar: :any_skip_relocation, monterey:       "8cd8128ab1e13823f94243b5003e0327183ecd3051d72cf27aaef2b40e2f2273"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "967e77023939f107cf9309e0aa84846bce5b162129f43ff02aa5653ce5472ca4"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "4fa589c569b0d154636356cebf0fcbac002f89631f864225eab3063891dbac95"
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
