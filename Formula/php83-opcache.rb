require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fecad56d537855cbb70087b28f1e855fe363e0a0c93bd8557dc676372e8604b8"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5642133ddebcdc247ee1da7a9b1e92683014a11afc0ebd35559d173638300197"
    sha256 cellar: :any_skip_relocation, sonoma:        "2456c3aaea4e53021d8b5aae7279118ecd24f2a0ac1ca15d0aa3195252b6f71d"
    sha256 cellar: :any_skip_relocation, monterey:      "abc918c4f76aa53c7c111402427a1cf188b5c3f5903ac9396112aa2cb25889a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fc3a32b71732c2e31fbaea74dc059beef189d799ce5b10a46805373ffd1f171f"
  end

  depends_on "pcre2"
  depends_on "pcre2"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

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
