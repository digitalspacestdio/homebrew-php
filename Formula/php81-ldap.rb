require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Ldap < AbstractPhp81Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a33f64288674f762f4de73b482cb1c9596e166d3aba8a0858b23af9b0f30b4ef"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4508a6a91b1864d6d2a3317f48fc2f2dd6811dd934df45346d7d48ed37de340f"
    sha256 cellar: :any_skip_relocation, sonoma:        "7993d52cbcf66797ee71b60cce545f4814d741b1e052b64b7ff34a78c40bc3f6"
    sha256 cellar: :any_skip_relocation, monterey:      "1dd551a41abde74ea5becab802a00c12ee4deb94b08735a80fa424fcd3e69ded"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "90949a833f6ff1b2360cb0fd5fe60803444b772259fa797cffb51faaeb24bfb0"
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
