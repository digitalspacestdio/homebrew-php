require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Ldap < AbstractPhp74Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4201d5ab2694207484e5bdab93283b1d2cebf57aa644cd267ef81a43806dbcbe"
    sha256 cellar: :any_skip_relocation, monterey:       "9940be981f36a401eaaeac839750479ce18149d33edc9390b8c0e7c19f2719e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c02381116402c66c4572436ac2b886d2cd5824b1217008f626a1d5e49d4a2f11"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "c028866870ea3450d5cbfaa69aa7121abbf966aa952dc427e6e728310eaaffbd"
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
