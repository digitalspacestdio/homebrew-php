require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Sodium < AbstractPhp83Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d684999e1fef41ebebde225e68d84cdb182d9d976a4468804250d0e7cbc5a32a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ae78bd279d31ca617e1b7a3d54d5036644a87fd0087ce8f4e68ce0f38b13fc0c"
    sha256 cellar: :any_skip_relocation, sonoma:        "9cacbd8b21bdeec754cbaf4bcccf3b65dfc2d13a1b0356336e0a316ae38e6529"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b32541101272c445ab6b1b0db6ef151472d56fec40f070b48cf8aa20818f10fb"
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
