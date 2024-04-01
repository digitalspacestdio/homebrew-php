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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ecedde23ab9bbefed11e4b043de381923b36005fad6adfe3a9876c9812b03a6f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9134529def4fdaf6c85098af52645a5b57b4c150da45f0b2bb71f845dda90cca"
    sha256 cellar: :any_skip_relocation, sonoma:        "aab97ba30b09e144ec5106bf2a4d1cc5ca0c112cae9136098dcec534236eaffb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1bc6743f7ecae76d25e09b8dae08827b7ab49cee7b8ef5a38ebeb14146cbe71"
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
