require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Ldap < AbstractPhp83Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4ae2602104d9fa4ffa15ebc24b2bb1f5d9465de6a13b8cd244819091e9dfb33f"
    sha256 cellar: :any_skip_relocation, monterey:      "ea9e5bedd1bd8fba59d70831edda21dbe9e7df0bcbf7e675570ff0bd4fb9097b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ebe22a687d14c1b60a351c799847171caa2ab877e6eaea79f7971cee676d6565"
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
