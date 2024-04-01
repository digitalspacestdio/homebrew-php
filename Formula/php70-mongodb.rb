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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e0aefdbd49115ef2740ff6f5930ab0f1214e5b88fa567ef33b013197afc56159"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e9222b8db8c05169ee13b4ce21b519d6b2e89168beb2f4a05cdc2aab86bacca2"
    sha256 cellar: :any_skip_relocation, sonoma:        "5e381d6806869e12fa18c6cd62bb2381f017aed177c0730daee0f5d09324bf75"
    sha256 cellar: :any_skip_relocation, monterey:      "37fc0d4c90253749e6348ca2d137fcd228107dedec752cd37dfc07ac9860315a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8bda4fef46aa7cf9a2ddcec171d6488f5898205fcfb948ec17b4861821f8487b"
  end

  depends_on "openssl@1.1"
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
