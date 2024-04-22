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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "875c4ef3cdafae929159960d596f6b78018daab745646df8c0b7bbe1ee7c9445"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "364fdc7cb213347a52e55545b8cefc64e83b135e16bf751b8b87ac169508c938"
    sha256 cellar: :any_skip_relocation, sonoma:         "ac2de4ede838b38fd86dbc6e23f57b53c3f1ac4d086a2b12b33d0bdcbf67b627"
    sha256 cellar: :any_skip_relocation, monterey:       "f56a194df4a7c6ab0d1de7fae718d55a8537d97d34cdc2c8d0f755cc4b1d8d01"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6d191b205eddb81596d47acc5c392bb1822618cc7ae4aa91333ab54c7fcca06a"
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
