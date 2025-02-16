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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-105"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "02e8d69b98daf0b46e9d0bf681179209884c91e4043862500ce813d741e6ecb1"
    sha256 cellar: :any_skip_relocation, ventura:       "6de460d9fc5c63d5de49f8d672e49390cc5b89567d16a7a37e3dab5537c78ead"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@74.2"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix} --with-openssl-dir=#{Formula["openssl111w"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
