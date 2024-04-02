require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Ldap < AbstractPhp80Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d83eab1e8b60aee8d1ffdea8a488f8a53991ab5bb0c3505bb11a3d89581297db"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d4810a7aad2b28eee1e8eb29eda0437ad2c0e015e5706f2917576ab8a48a2d90"
    sha256 cellar: :any_skip_relocation, sonoma:        "f3c712196a11fc850eddedc82fcf48c69fd31e7ef3592f9f05510b7b7215cc4d"
    sha256 cellar: :any_skip_relocation, monterey:      "1e297256ab5a5e197bb5870c2829351f2402a59ea15c0829afc260bbef5956b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5728a722b06cab20a135f2ec91a70ad762b4176e1931ae47ab069c98fb7ba42"
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
