require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ldap < AbstractPhp72Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "46472c7ea73fc9cbecd0218708a632ad5370cfa6b69203a9770a64ddfb248ac4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2bbccf1f6ec756fa01a3bfb027174c5070706d7daf6e19f3fa283e65ed7d391f"
    sha256 cellar: :any_skip_relocation, monterey:       "2986948d32b0b378f5fe13d48b04c9da5f506b4bf62d76f21619c4564a038be2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0743fc9120fd4f5e6315f60949425a09baceaa661d6d7442e2be3766b52e06a5"
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
