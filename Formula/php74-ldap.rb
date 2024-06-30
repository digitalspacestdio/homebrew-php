require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Ldap < AbstractPhp74Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "433dfaf71ef6607c98d3e3f63f2e2d13a5a43e1764444a3f5406a93dd8e1e6d0"
    sha256 cellar: :any_skip_relocation, monterey:       "d4d5cdec30fe4172cf67b3a3a6fa315225cf6f72bae3b7b7ffd7b03f5798b79f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e72cf9975dc1a567ed156f3d7c24593f2b867ee4d03f7a3a907b6e3b6f3f0ff2"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5b8070fc7e1e91be3792b9173e26e35d5c2a6f3e3580278acecf63c361150b07"
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
