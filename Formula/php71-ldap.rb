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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "db1320b58fd3bca94cfc221751cb08f06cdbf09ae34222fe05802bbb8ed9280c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4e4f1e3c8f5ad7d466ed736b115071367d99bd6b3b5f4f65739c50e8ed962bac"
    sha256 cellar: :any_skip_relocation, monterey:       "40d70ebfbd7e4d0a19f5284bae752ad763bde0b8c6cfa2be5834c381196d2c93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f055253ea897026dbf6609e9a502df3e476bf270a816db1f2e5cc22f83695da7"
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
