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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1a108d2d8d44740bd035f9ec45add4b0c1aa4723d682442ff3ad36f1f524b1bd"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d00962d8758060b9de61f3390105b0be988449da7e6235da3ce703cea00d52ee"
    sha256 cellar: :any_skip_relocation, sonoma:        "111278c8ba9b9d92dfc4034ede9773fe49c62fa5b4313bf699b58e73ac4d3865"
    sha256 cellar: :any_skip_relocation, monterey:      "3a705e129837c5e0eab1b84f928242f4c00b6eec6fa5b8cace22f60635ae177d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a45b1fa940dc6c59270db8a65455d33400ddac9570761e2b57d265e64e6d5b5b"
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
