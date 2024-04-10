require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ldap < AbstractPhp71Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "db1320b58fd3bca94cfc221751cb08f06cdbf09ae34222fe05802bbb8ed9280c"
    sha256 cellar: :any_skip_relocation, monterey:      "1694cd299831eab0ec67f125c2aaadf6e11571a1ddc1941d63f3e530eac621d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5fcaa59773d84e952814da94ec8ca81956ece79181b57aac0eed74c8794bfb0e"
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
