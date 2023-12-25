require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Sodium < AbstractPhp83Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8dc8f4084ddd7be59771a8a8325b4ecd42dce844e9d5e127126f50d6393ace7e"
    sha256 cellar: :any_skip_relocation, sonoma:        "9cacbd8b21bdeec754cbaf4bcccf3b65dfc2d13a1b0356336e0a316ae38e6529"
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
