require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Opcache < AbstractPhp82Extension
  init PHP_VERSION, false
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d5106145cc16906ffd2d480cab6a988281d10ea1c3ae41b314225f6257d37ca0"
    sha256 cellar: :any_skip_relocation, monterey:       "35cd2605bf86980a47c359215091880f937381c1dee80a6e369a8385e1a61921"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3df814c0fa50549c5be6e641eff26afc3931f60c53cfa8530e935d448f9dd86a"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "4340c912c4b091c2086b277713bb58fc777788a6385bd5e54e6e77d1cbe65f84"
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
