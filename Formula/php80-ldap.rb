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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5baa24fe5a904a42ccfc719c7452fceda97d65605ebe15437636503e9dfec02e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d4810a7aad2b28eee1e8eb29eda0437ad2c0e015e5706f2917576ab8a48a2d90"
    sha256 cellar: :any_skip_relocation, sonoma:        "f3c712196a11fc850eddedc82fcf48c69fd31e7ef3592f9f05510b7b7215cc4d"
    sha256 cellar: :any_skip_relocation, monterey:      "ee23c0ad1bf7b2c13fa305a2c7109c1e4a87d712df6a4b09e412b0ad0ed0a51d"
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
