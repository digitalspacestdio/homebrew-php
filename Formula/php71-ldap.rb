require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ldap < AbstractPhp71Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "55ccce073e639b5a9a36a201ca038c5cc5bffc4597a72d99e7031d4cbd42e6fb"
    sha256 cellar: :any_skip_relocation, monterey:       "c5bbb90e2d5c6733f0b3d9e5d7bfc308f8ef4f002c20af5a5bcc8c56f3431c73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9e5a76d5fa609b687194660410afbafd62515c9dcf57a4579b431197668f96ef"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "7015356fda6a9c3888ce6aad5682e8ef6b9b64131bdfe2643e6466e794dab6cc"
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
