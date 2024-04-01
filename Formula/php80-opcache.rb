require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Opcache < AbstractPhp80Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "45eeaaac7e6c6fb9e6bc797dee13bc708f91c8f0ba77b6d6fe0f1a4e9207111c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "efe5dea6d02204477d95d1ae70130c6c18e38da2f19a406b0c3e6be1acf6181a"
    sha256 cellar: :any_skip_relocation, sonoma:        "29576f659cbd78d52296e7aed5166d96ce0abd76ba3f92595b998026aee30fd8"
    sha256 cellar: :any_skip_relocation, monterey:      "f6c688d78a56f5b52cf0142ec5455fb837573aecb9db2af83bf4855d1f6e74bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "358d35e71c031afcb4670086e6debee5d01b04a9a1d1201c413db78e2a63f9ea"
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
