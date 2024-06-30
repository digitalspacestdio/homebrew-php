require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Sodium < AbstractPhp73Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "67792a31c36840a08f4aac959a299cf107c65e56b65d66ecae4346a2846fdf81"
    sha256 cellar: :any_skip_relocation, monterey:       "e714b503c190ab3163eeec48cc7082151a43b70fae35784ce847f94306431fb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f37379afe94c7294c0e9d51d4b56da264a62421e9d1ef869cb69df00611aab31"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "fa27e7025c35e481e4494dab6feba52cc8657cb4eb80722cc9928e2d7d617d18"
  end

  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-sodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
