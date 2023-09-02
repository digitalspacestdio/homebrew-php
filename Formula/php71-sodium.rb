require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Sodium < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.10.tar.gz"
  sha256 "2eebf3772d7441449b47abfe8f52043b9c6d6b5aff66aebd339c5d459d7fca28"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7d0f3acb3c59c9ef5d2737a33a4bf6801e85d958a5545edd5ef23e20a0625d4b"
    sha256 cellar: :any_skip_relocation, ventura:       "20e7d7768354a08ee5b3aad490b3df7c1a24968efebc54a4c3ad1bb5df02c0ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a02d3d21aeceff1089f427362926930afdc010c2475ebed97f22dba1ec3a4475"
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
