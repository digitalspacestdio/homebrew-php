require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Ldap < AbstractPhp82Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5c20aacff8e041e1d391b64259a6612c26b31bc4e8511e8ab08aca6b0cfea32a"
    sha256 cellar: :any_skip_relocation, sonoma:        "70e729e355ca78c28a87acd54a3c8d648c59459a57970633ab419b7f95016376"
    sha256 cellar: :any_skip_relocation, monterey:      "c041dae1e8244e4fb17509e93c045a42f6dd612482f62a8f4769b600e51ba735"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd3ec0dafd05e18e528291c771c91d9370017e1648c3a144a6f532bf7517a220"
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
