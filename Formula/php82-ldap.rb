require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Ldap < AbstractPhp82Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "91152b7c31cdb98183b535c0608fe1bb980b48f5b20f88cbd64823cbb726f5cc"
    sha256 cellar: :any_skip_relocation, monterey:       "69401bf7590d49f66cebbf25d2ce1463cbe9b22bb8ed65cd2fcba2017d7f213b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e071f8685e74cbabbad4e7048d123a016a5450ecb776befa5bd6aead9132b137"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "d07de990f02759dcb31fd723ef4320656b19ba53359dfa37d59a8fd4221a41ba"
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
