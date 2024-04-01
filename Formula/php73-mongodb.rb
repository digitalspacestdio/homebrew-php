require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Mongodb < AbstractPhp73Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3633981a79bb9041bbc6734fcf36867fcb8f6fe6c83590375f3f195f258d9ddf"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ae2df85342c4dc5d01bd96b5cc0a0290b9480386bb0d470e4303c759eda34569"
    sha256 cellar: :any_skip_relocation, sonoma:        "73694d2c9ad29d5966645dd3ba7a15039d66ff0144a05eff197d828fc629f2e4"
    sha256 cellar: :any_skip_relocation, monterey:      "f3efe33eada6294a53edbd0d64885fd65e22f7885445a0f22b7490a3c2d96489"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1799185a4af5d8fc29a853d4afa340cc3bc2226f42b578c6504af2ff0d92e85"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@69.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix} --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
