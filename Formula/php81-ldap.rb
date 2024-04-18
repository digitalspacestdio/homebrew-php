require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Ldap < AbstractPhp81Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d16fa0d29a599c0b883aa8f88edcf80dcae14753a189d63b24dee48ccddced66"
    sha256 cellar: :any_skip_relocation, monterey:      "75f1a8139380d5aae8fd507e9e80da933e7ceb6e6e3023ddf0efc99efd84d0ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c5ce6dd840603222c29c4da56ba34c4f1f6948ff0d13a54bb673d9b9e5f518d"
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
