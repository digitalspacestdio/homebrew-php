require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Mongodb < AbstractPhp80Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.12.0/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.12.0"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3df6be0a32997c01718662ba1474ed7f184e1cb6922603d42a7e04b5741a48c7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3afbfd54b7a26bc3f471e18a1029d0365a2a7a28da38d30bafadb71e4d47a096"
    sha256 cellar: :any_skip_relocation, monterey:       "878452d667e06930dc84b0c351a1b330ae2e61fad301af0e163dd113ad9c9b5c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bc5503cd33f1890a1661c85cb5c5cdc9b909a301d8d487351b9fcdeab841d545"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@74.2"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix} --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
