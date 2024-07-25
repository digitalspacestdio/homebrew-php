require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Ldap < AbstractPhp74Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1f13d8ed1a1b69d4ce0fc9a0edbe59bb18cc9f0e9ccb2d3232ec0446a323eabe"
    sha256 cellar: :any_skip_relocation, monterey:       "05969901e0f327de2bb2c95aa74d8e7b5f916cc9c8fee121b70b5f941b2bc4de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c261782945f8ae1ce038ff74d64d053ebc07aff6a4d127912540d5bb1ad131f"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "4f320ec7fc11ce64e18529014012dd0f1f38a0b0d3febc138b628a77b04e2761"
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
