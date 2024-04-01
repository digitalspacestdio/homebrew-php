require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ldap < AbstractPhp56Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c39e25279b5e8ffdc9cedb433700c0c163d3dde971fafac0d4bbf04e9761c065"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4b65f62b09eef543cef12281c85b1b5b1bcb3abbdacad14247007a69fdafa233"
    sha256 cellar: :any_skip_relocation, sonoma:        "db1f288c81223150fd63b79b3d4b0fb4cd952e9f653c5f730a608abe4b8a3e02"
    sha256 cellar: :any_skip_relocation, monterey:      "de1698704f092f85f1f0ce652133491e0e4837dc86067ab66c7e59449a5681a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b80494e89861cf3786d7e82c539cbf843f843c537b243d485470817376ac018d"
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
