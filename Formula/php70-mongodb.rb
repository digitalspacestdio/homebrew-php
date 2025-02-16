require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-104"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2a6b1e60be749001ac0471a15d024d3a3639592a71ec22be50769fc60f419e14"
    sha256 cellar: :any_skip_relocation, ventura:       "5d36e5e9b19dd4e943ccb936d1057c62b944fc9cff760a1689ecb013b36a14ce"
  end

  depends_on "openssl111w"
  depends_on "digitalspacestdio/common/icu4c@69.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix} --with-openssl-dir=#{Formula["openssl111w"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
