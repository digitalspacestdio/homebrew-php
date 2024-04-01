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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "397b9e4ab696956179fe235955c9fe2e219fe7e8c23550e6f223bca23aeee4f0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "77512e8e7480adc06174fd626a74101a7eb777321c812f547e5e51d57f9bb2b3"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ff0287a0dfa4391f4ad825a5de688df9402953b1f0659a22ddbc1dcf83cbb4b"
    sha256 cellar: :any_skip_relocation, monterey:      "91eb57be6667192905b43bccdb34b84776e25e1db35d8962ae184097c5109f6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e1d6f26ffc64395ec560bd6671c8cafc45400e8a3fd53a8ee95e9645d808b72"
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
