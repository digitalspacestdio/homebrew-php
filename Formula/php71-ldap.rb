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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6fccb57a56eb9a9318ecb9d3010a7ec1dd59777ff19801e45cccb7ae3effefae"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "905845609a5223516b2703a06af5b479dd7147d760dd86f39eaed6af61a228a3"
    sha256 cellar: :any_skip_relocation, sonoma:        "e0d0617eb766cc7282edf3f010f7e84fc19777c0db5ab2221072e0e3ab8a5b58"
    sha256 cellar: :any_skip_relocation, monterey:      "e07ac706e3ac3e472d8118d85d98351da988491be6bf594c450f9f4e9c21d036"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d5672853aec42c0ce5d5431bcf660f6c8bfdd3f8b61f77ac2d936d4d61ae2e50"
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
