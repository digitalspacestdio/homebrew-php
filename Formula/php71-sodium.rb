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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "aeadd1e2fbe938afa95ba288f1489609581b604b3fd2f65889bdd26932710063"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bdf0f668f8fefa614dded9d0c37a1106340877ac3197cc83bd54c0b10305a1be"
    sha256 cellar: :any_skip_relocation, sonoma:        "1a870a6281bc98bd2990097f52d4532c9d13611441adb3fcc37bf353f6945ffd"
    sha256 cellar: :any_skip_relocation, ventura:       "20e7d7768354a08ee5b3aad490b3df7c1a24968efebc54a4c3ad1bb5df02c0ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c3f7c7acf8f5e6bee8a958822e447bd7f1cf0c8bd496b793dcde1ab8b40604c0"
  end

  depends_on "libsodium"

  def install
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
