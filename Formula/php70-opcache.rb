require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Opcache < AbstractPhp70Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ff328e3fa311a31934e773e42b8a5019a80645f309192decd5437b590455950d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "43df993e222c76275c8975bc650a71c218dcf831df2010ba688a36176293f411"
    sha256 cellar: :any_skip_relocation, sonoma:        "e50bd331819b72a8b8d481218274946547f1a29a2455ba9e8c2b11d75e60295f"
    sha256 cellar: :any_skip_relocation, monterey:      "c0b3a1908a27b618c2e0c222fa57ec920fbc7bba17720133adbe7466f734a944"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdb2cc087e31d6a88cbc9979b09a7995512f93ac4c0ebe96d6fb25d0bc8be9d7"
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
