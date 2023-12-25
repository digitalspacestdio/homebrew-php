require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Ldap < AbstractPhp82Extension
  init
  desc "LDAP Support"
  homepage "https://php.net/manual/en/book.ldap.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f7dfedf51a37baacb26adaf6c501fe31162af4c3978a3164b27c7432c5488b0c"
    sha256 cellar: :any_skip_relocation, sonoma:        "2c7242e0f9abc2e0217a0fe770467a8b01cc02fa5a9a77481888a94c1fcdce51"
  end

  depends_on "openldap"

  def install
    Dir.chdir "ext/ldap"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-ldap=#{Formula["openldap"].opt_prefix}"
    system "make"
    prefix.install "modules/ldap.so"
    write_config_file if build.with? "config-file"
  end
end
