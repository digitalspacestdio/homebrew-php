require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Ldap < AbstractPhp80Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5baa24fe5a904a42ccfc719c7452fceda97d65605ebe15437636503e9dfec02e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f9193792d51838da11f1bdaf21a28df0a6496b56b0b3d3a0c0cef9a24454e927"
    sha256 cellar: :any_skip_relocation, sonoma:        "418013c382519a6dd2883e6e0d5b6397fd40366f32ccdb99c07c92f3ccca2506"
    sha256 cellar: :any_skip_relocation, monterey:      "ee23c0ad1bf7b2c13fa305a2c7109c1e4a87d712df6a4b09e412b0ad0ed0a51d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c412af52eca4aec540ef6ae91d284c7eb56a36179d420f03907a389b22c0c243"
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
