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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b3135057da7eff29cd9fea8eee0d68650b77f12ed1ad3e4ccc74fcaf470c5a81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "862f50f451206ad17fa357bfd37a5c01a38abaae90d09e5b0d3d9c20e733090c"
    sha256 cellar: :any_skip_relocation, sonoma:        "6dd0d3543ab7c3995be7eafdc5eac4b65fd9332e2564d450926cdb67e6c59642"
    sha256 cellar: :any_skip_relocation, monterey:      "4c983c029b754a3bb6a832940c369297f339e3241a2b1d271379458cfa54b2a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31bbb757da663a0934ff8057635e7cfbbc94ea67080833e1e2b91acd496216ed"
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
