require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Opcache < AbstractPhp74Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "91c245d290a631519f50caf572408c5b02ea7110315c50ca0da5deaa14668772"
    sha256 cellar: :any_skip_relocation, monterey:      "2f079ed1b52abd26222759ae997f61fe40c594d9ea34b7630046888cd5897df8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1374c6c4fdee68bf15c7dafd8cfce66b2a6aa088725669261fd0e708682e3001"
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
