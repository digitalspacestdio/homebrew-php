require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Ldap < AbstractPhp73Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "009f0a00ba5da34526fd1b371c38ac2f393e8a19ad6d91040dfa42e637078929"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "076a8ea0f846c7cf6021ac7f7bf8fff3c24f277450a3dfd7480c4c043017225d"
    sha256 cellar: :any_skip_relocation, monterey:       "62e5d846fddbc5ffc9c461131425e84a31b63d92e58eb8fe962af3fb0407416c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "62d8505cb01e27649925665fe82dbb8eec6a246c410d8505001654afb700f5d7"
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
