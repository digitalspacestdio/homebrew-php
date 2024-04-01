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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cc4e4fdde2618e53c887d720b835d83c6177fe2dfe28dde8d6f819a8fce9cd4d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c9c2e15c4dafb89fa71a0404b225cec73cdeff85da4ec64a8800c1546eec6ae4"
    sha256 cellar: :any_skip_relocation, sonoma:        "71a99f3ed2a13d9434e12b4f1ac852b0492dd26a5fed26c2873e11e8c99876c2"
    sha256 cellar: :any_skip_relocation, monterey:      "660cfbf2b7926d1f081c74d402b21e0cec54c5f9d9f290d9393a14a6793ad803"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c0b70a2782a529e7b05c692b5f6f1c798901b765f2889c2a37a0062e89cd69d"
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
