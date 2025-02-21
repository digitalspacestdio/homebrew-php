require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Mongodb < AbstractPhp74Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "11871b236e223cf3e20397a057e0dee99366797787f0056a5490b15937e114d9"
    sha256 cellar: :any_skip_relocation, ventura:       "156f77dce5cdf34ec75afe73556d4a54444decb093b44d9f4dfad6e1eb50e6ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a2d15459a07441662f0da46b7b0d9fc8e5d2ae827457f6fd257e8747d92f889"
  end

  depends_on "openssl111w"
  depends_on "digitalspacestdio/common/icu4c@73.2"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@73.2"].opt_prefix} --with-openssl-dir=#{Formula["openssl111w"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
