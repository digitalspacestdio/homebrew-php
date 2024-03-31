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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "108c9a8e8bc3413744208abc4f665e73368bbf407f574f03477ecc40645d137c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "10f6040bdcbdf003b298933ab442632143bb5e0d0731f2216afc6387ba48ad23"
    sha256 cellar: :any_skip_relocation, sonoma:        "56f70d07c70a84ba7f7b3f6cf8d412e693aaac6af1298c29fb11b0b73343e80c"
    sha256 cellar: :any_skip_relocation, ventura:       "14d20ddbf9b61f4d6fc34a673015893c4114f1e436e4a6dfe6f82ce9fdc2aef9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df5bdbb5a3e7e4b98003002707f996bb8884c6e5e8975b4c3926372981836094"
  end

  depends_on "openldap"

  def install
    Dir.chdir "ext/ldap"
    headers_path = "=#{MacOS.sdk_path_if_needed}/usr"
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-ldap=#{Formula["openldap"].opt_prefix}",
                          "--with-ldap-sasl#{headers_path}"
    system "make"
    prefix.install "modules/ldap.so"
    write_config_file if build.with? "config-file"
  end
end
