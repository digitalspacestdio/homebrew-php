require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Sodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.10.tar.gz"
  sha256 "2eebf3772d7441449b47abfe8f52043b9c6d6b5aff66aebd339c5d459d7fca28"
  head "https://github.com/jedisct1/libsodium-php.git"
  revision PHP_REVISION
  
  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "54a28baeaef31ff1fdade9b98c2c91371531360acd0bd55877ee6bedd6e55c08"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "683e85beffa565d6549f912dbe684419d8dcbfe65222a4ea7eb1e41e6814c7dc"
    sha256 cellar: :any_skip_relocation, sonoma:        "bc232673d65559a598729e688d6aa68f14d9820ceac0c6c61e818c2a567c72a9"
    sha256 cellar: :any_skip_relocation, monterey:      "d069968379d81c939249f0d07ccecb2ee496a251963a3cfc139fa2520a296e52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2bc9549a9a2cdc74ba036e9ce643425f85e4065431496c8cf448f6fc39b555f"
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
