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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "afebce8fa27442a3391417476c581c19c2be8521fbe935d3e1f66c026fec68b0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "388ff7709988311fb716bcce80e28ecceacf9ddca18c6fa6cde8f3b644c7c31f"
    sha256 cellar: :any_skip_relocation, monterey:       "c862350587bf7751d6fbe77cf266c52149a87896facdae89164c84996be952b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1fd58689f9a48e8ed0a05c621e181cec637fbf40b4c716439f72f5e0b2763cee"
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
