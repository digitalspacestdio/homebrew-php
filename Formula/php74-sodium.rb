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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "96baf59219656f7a3717bc532b58ed11bddcacae444c7089aa8435383c7e9984"
    sha256 cellar: :any_skip_relocation, ventura:       "dacc1966d6227c1e41e2c146eae68ad3bc9a6db1ab7d92b4a725f6fedca990f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d65b41de1c952d9dfc118be99986c09970217b8f2fb5058704f25175eabe4b65"
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
