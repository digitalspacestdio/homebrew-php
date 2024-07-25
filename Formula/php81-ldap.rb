require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Ldap < AbstractPhp81Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b40c0f317b339dd6b64ae9da34486a82fa0c49a28ae7ecdbad56824a3809f515"
    sha256 cellar: :any_skip_relocation, monterey:       "9322c87a9012cbdd78e3a4a6601c14356042a6d0edac0ef8be2d1a733cf7f2e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "231a038cd454b1efa7bda727ace8d9d09b81c0803787a99f910015b54b4b945d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "57fc2f22cc446767a3fbe326e197ec75bc2ef645c9ab1c0de4c44c29b521edd4"
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
