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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a9802c807e8b9404ac92fd632fc2d67b3fef78f95635c48230b8bf20f71378dd"
    sha256 cellar: :any_skip_relocation, sonoma:        "8ebbef1638b5759976034257473d6efd74a4a1c360d98b401bc0ebc7834aace0"
    sha256 cellar: :any_skip_relocation, monterey:      "7cc1f5b9d163c1a9b608f97682392c8a9e7bfd1c738b0c2522edc52f8d0547a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3687b00f139c86a25ad76025868e778d26382d6d520e99de7b23f0bc17a95347"
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
