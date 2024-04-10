require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Sodium < AbstractPhp56Extension
  init
  desc "Modern and easy-to-use crypto library using libsodium."
  homepage "https://github.com/alethia7/php-sodium"
  url "https://github.com/aletheia7/php-sodium/archive/1.2.0.tar.gz"
  sha256 "cf8365e5d4862bfbd61783e0e8cdf4ddbf0124a1d93492c33a8a05919af08893"
  head "https://github.com/alethia7/php-sodium.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cfee4e2b1d20997ca6b4da558940cfe5ad48f147bf02bcb42b52c83b7d5713cf"
    sha256 cellar: :any_skip_relocation, sonoma:        "8a1ce8e3dce730e65f2f525d3a55fad2c1a3805db415e9c22b67ffee05ae73f3"
    sha256 cellar: :any_skip_relocation, monterey:      "bc8c30a45347f5da6b2318c627cc9d1a219d6fd5c3739a66f4e471910236279c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7edd94e00797c5a6e63df01639d19d9a5f4dc8f6525029557c01626d26929a7d"
  end

  depends_on "libsodium"

  def install
    # ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                              "--with-sodium=shared,#{Formula['libsodium'].opt_prefix}",
                              "--enable-sodium=shared,#{Formula['libsodium'].opt_prefix}",
                              phpconfig,
                              "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
