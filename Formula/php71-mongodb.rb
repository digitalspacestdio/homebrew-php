require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5818fd34eade391f4e77047d0ac082b370d7f8482a40fe62db029c5d7db9ead6"
    sha256 cellar: :any_skip_relocation, monterey:       "467dba6778f11e001ad294767bf4841f623512a08c4c96ce24db77c74efb5e22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5bd3a4ee657cd79cf0264fcc304aee60d7ff9c7c1680cafb3a87397edc6d90bc"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "fc522bc3a4b7079742da649e926015d8f6a1a8a1002788e658a0242e9034fda5"
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
