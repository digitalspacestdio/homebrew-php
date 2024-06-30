require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Ldap < AbstractPhp83Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d9283e21c4f6780489f883d79032bfe8e686b62dc7b1b7206508b50adb000917"
    sha256 cellar: :any_skip_relocation, monterey:       "fe55a7cdb1e596ad615ba93eb172d79819532ff8ec015f58bdcab6daaffbcd9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bfb6a2c16483fb8b5ec0fefdbf473fd178a6168d631c99a06d2f668af86c3d16"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "3d513dbe2d2679ca0cb27e5b0a21006aeffbefb65b0d8fad20e2001590565559"
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
