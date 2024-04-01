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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "83c480808a5e3c4770f7ac87d2c04d127d2d650e4738964943b5036c9cc6f8f5"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "230cb3790576b8c76dc714817259358435c96a58483824dbbc6f2e7410d3d641"
    sha256 cellar: :any_skip_relocation, sonoma:        "8ebbef1638b5759976034257473d6efd74a4a1c360d98b401bc0ebc7834aace0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d9a17ea18e7fb7d2f82cc0e53a8aacd1e88915a4581c46264bf0566b32efc41"
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
