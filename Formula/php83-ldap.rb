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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "83a69776760b9db2f4135e37fe4e9b044edab821105af58afd3644fde112ee6d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "50823e7148668a838cec1612dfb863a59a2979ea0f705364a1efd811fbfae1ab"
    sha256 cellar: :any_skip_relocation, sonoma:        "f37bf7f2078dc5c0c66610fcfec8bdb3da3f243fbb900a2d21db59cf8b5e35e8"
    sha256 cellar: :any_skip_relocation, monterey:      "91eb57be6667192905b43bccdb34b84776e25e1db35d8962ae184097c5109f6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9aef9b3bfe294f4ef8cc803a3983c9511577ea9887a381b20fe42c0db3cd1b9"
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
