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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "02b8c96fc681c97d0c4cb5639770a4a0ec418b96510831eac282376e789d3ee5"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6a00941ce60b772589d6e5d465850c564658f942ec37b5e695862ccf682692f4"
    sha256 cellar: :any_skip_relocation, monterey:      "577306e4cc409fe06fe264ef48bba6a07eb507c41f072ebfd2769fcdd7bb7495"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f7fcaebb39946c687fa6770b29210d24337bc7c98d885c98dff0c742c35d011f"
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
