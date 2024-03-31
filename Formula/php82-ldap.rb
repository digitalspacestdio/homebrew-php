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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4b279a0374426421df98ec27b1a6abbd6122c01d46561da912a43041b15fbb88"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8189ff7c4cb2ef9f1707f1efef36d4a5debc8a8688f6a8a11a9d91a9d7c4530f"
    sha256 cellar: :any_skip_relocation, sonoma:        "2c7242e0f9abc2e0217a0fe770467a8b01cc02fa5a9a77481888a94c1fcdce51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04bb65f7d6e76dff56a8d85a9ff94fec7c350984d48eff34ffa0761ce924413a"
  end

  depends_on "openldap"

  def install
    Dir.chdir "ext/ldap"
    safe_phpize

    if OS.mac?
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
