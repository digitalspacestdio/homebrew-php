require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Ldap < AbstractPhp73Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cc4e4fdde2618e53c887d720b835d83c6177fe2dfe28dde8d6f819a8fce9cd4d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d2fea195990689ab4c8b6d4e28ca172bed2250454d7fcae537fb5894efe7166f"
    sha256 cellar: :any_skip_relocation, sonoma:        "8f33b3d847d8e19f9d12da4878003103f646ccc2aeecab6fd36f5c24497783ac"
    sha256 cellar: :any_skip_relocation, monterey:      "660cfbf2b7926d1f081c74d402b21e0cec54c5f9d9f290d9393a14a6793ad803"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "08ca454545275ebb0094a92267a3b82a1d385d5f38df0414dae15f4f7d7db212"
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
