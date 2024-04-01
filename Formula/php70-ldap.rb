require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ldap < AbstractPhp70Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "59993f1b20d44a51c635e92306fef2408a1b1b11cb21a46355256d20853cdf24"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c90794b5db91e0b79d05ab8fcc580da5feb0e9f4cb032bfb9057b3a5b59989aa"
    sha256 cellar: :any_skip_relocation, sonoma:        "1b5cc1ae5d02dc656a7a9d6429eab59c2615174af45b5f51934d70b5ff240b5a"
    sha256 cellar: :any_skip_relocation, monterey:      "1ee14ebd8c5e1ad3356f790c5e4fe4144b6231d61dc3c2bf2b4074d5cbbb8a91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3daa6ccceb454a230a9ce472b7263918f715e3dae4e42d2179f1ed4263ab6ff7"
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
