require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Mongodb < AbstractPhp74Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3312103e3a41645a2fbe931d48ef9c5f137d285677ee7ecba77a4ea4b3f92b77"
    sha256 cellar: :any_skip_relocation, monterey:      "9a9c2b3e87c54d714227277c89f936baab25e951203317ab0e7fecedd59592c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7756cb7d0a04cbaf20292593058f3ad6adcabbb1c5d2698d2b10c584dfd77419"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@73.2"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@73.2"].opt_prefix} --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
