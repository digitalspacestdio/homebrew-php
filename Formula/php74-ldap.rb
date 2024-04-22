require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Ldap < AbstractPhp74Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8104c5191847429fa0ae7cfda2b60c8d4ac05bc691d3ce5a13f3c8b61fdc5a12"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "29f1d29788a417c892918b2635af3f677d6b0875e011ee44cdeb1f4b93f9a961"
    sha256 cellar: :any_skip_relocation, monterey:       "759ce3ee15481dc3e4ec4ff7862809f1ade885302964c263fa77e89968600654"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8e22a1b7742f385fd914c91bbcabdadae0634438e1215d31ecaeb01dea6eb699"
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
