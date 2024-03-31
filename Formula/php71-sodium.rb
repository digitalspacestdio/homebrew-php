require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Sodium < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.10.tar.gz"
  sha256 "2eebf3772d7441449b47abfe8f52043b9c6d6b5aff66aebd339c5d459d7fca28"
  head "https://github.com/jedisct1/libsodium-php.git"
  revision PHP_REVISION
  
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e70442063189932f5ac66babfa73714b92542779c2c49987f2512f6011efb1ba"
  end

  depends_on "libsodium"

  def install
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
