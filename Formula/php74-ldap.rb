require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Ldap < AbstractPhp74Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "25081b3aa19056656d5e2f4ed5ffe6a46eead10dcb17c49a220ea575958eb958"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "53f2b45084d874818fb4607aaf0df8189923462b89d50e1805f7015fd6650080"
    sha256 cellar: :any_skip_relocation, sonoma:        "845e891435f785c183e4ad19de4fdd0def92bbbfa59523f4f167a541c01635be"
    sha256 cellar: :any_skip_relocation, monterey:      "c48dfcfbdb82840f95fc161f390c85c1e46b2ada9b464df7666eb65e77e37a54"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "549069c8021b77aa7d6332012accfacd3fa8e2f1d8737605a2514d2525192794"
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
