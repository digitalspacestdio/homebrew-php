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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4a3a1c5bb61b428845f065f885987c6e270b793b5ae33a62f1075779d01e8364"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "474b367e83cfd55d80259fa5ff499ce3f8fd6172cc901ca3365420d7acf12a74"
    sha256 cellar: :any_skip_relocation, monterey:      "90ab7ffec7a0da771fdc71495bbad7181a7f5b5744f6a56f627b83b518619a3c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "549069c8021b77aa7d6332012accfacd3fa8e2f1d8737605a2514d2525192794"
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
