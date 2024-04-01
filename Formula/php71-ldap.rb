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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a32c5efe272f97671fd4107c1f24ee0f8134da80fe178459688eb111b0d73e6f"
    sha256 cellar: :any_skip_relocation, sonoma:        "dd7334a11acb7e5feadf3c9a011d00a9c7390ea9833906a4b26843ee51909e27"
    sha256 cellar: :any_skip_relocation, monterey:      "e07ac706e3ac3e472d8118d85d98351da988491be6bf594c450f9f4e9c21d036"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6072171a6f5717f0785a1d9eb00f90e2c76e16bb108bc41fa5a480ad44e6d71d"
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
