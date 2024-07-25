require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Ldap < AbstractPhp82Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7a5ed4c1cbffb9798e500be5c1b623eb1afee93089d3cc24a2d9097d7dc8cd22"
    sha256 cellar: :any_skip_relocation, monterey:       "db53e99b15a320603df54fc24819640a2f97a4b879ef72a56cf3d0d4a3959c1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "191f30fb6c5cdf07ec8f0b8c1420f6639c61f92ade6643555f17daf5f5df9a9f"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "19f14d7d37c545504fd205f0cf0f3fb1704301d6265f8bf31428f417aaa2b336"
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
