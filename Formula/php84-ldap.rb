require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Ldap < AbstractPhp84Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d7fdaa786aa68617ba958f358cf0284218671cb3dd4b0988c3927ee16471ec49"
    sha256 cellar: :any_skip_relocation, ventura:        "8f634288b52558167117b84e89e8350b1699da688ab3bdbd12547d77cb2d998d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b68ba71ca6fa4baaa9ac470fc67abf3122a604c142532ea027031b8ab7cba528"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "ba766d57727847d02cb47290da4cf00be099123ed598236d2684c5f3feeee08c"
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
