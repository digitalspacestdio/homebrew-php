require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d8d28e72c0ec5723b7792f577859710f02e11888091eef38f603152772e75b81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b9c71550d619a635635861e220a970cfdac224d694ecf57d83772751ccb13505"
    sha256 cellar: :any_skip_relocation, sonoma:        "b91d30e7fe0e12f4b99c6161baa065cd130457583b73361378a39a9f1814739c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "023bff499a25e755bc25ec3415d92d1534ab5449d2d4955dfb2c64c93c23d29f"
  end

  depends_on "pcre2"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
