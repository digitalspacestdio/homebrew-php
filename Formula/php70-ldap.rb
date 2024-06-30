require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ldap < AbstractPhp70Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.0.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8411bea276f62ce652b529d2c9168ec8883ed4066685c30acdf09c08bc700c62"
    sha256 cellar: :any_skip_relocation, monterey:       "2a2a68796f5cbf1fa889610b617b9361b3f083ef7a952fd984cb5ff9b39d3fde"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c08c29dda54dac855928aa3b2c6dc9db8b60725722a2ba25d471d1d47f9af95d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f196e3a12c8d7f209a4fe175727797f6590f88e6ec97191bec06e8ac66ecca19"
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
