require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Sodium < AbstractPhp82Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "eaa84d82ee1aa073e67dd7379cc4735bc6e9c40e459f50e02bcd1aeb74717e07"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5ded3693c24dde1db8249077e36a881f313bc98ba5c2dc4dae047b9633d25c32"
    sha256 cellar: :any_skip_relocation, sonoma:        "01535d2f2652b14a87f2ccc2e30999dad300b03fa4db937d91f2bce1f37fb6f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea9e75430e8e60f975d6cba98ea356e3acb4ed9876eb1587157c400003aab3bb"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"

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
