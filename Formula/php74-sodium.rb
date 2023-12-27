require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Sodium < AbstractPhp74Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "07463ebc213902c018adfcbf4b004b8269287dbbe3842df2aff9582e23612823"
    sha256 cellar: :any_skip_relocation, sonoma:        "8b55166b8c955c3fe4e0bb3a476fd14690b51e66a7b8417c9b2ae8b08e6423a8"
    sha256 cellar: :any_skip_relocation, ventura:       "dacc1966d6227c1e41e2c146eae68ad3bc9a6db1ab7d92b4a725f6fedca990f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "51b99853099961ed74f4a53c678f6e97974ffa2198fa0945f32a1647b31c37fb"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-libsodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
