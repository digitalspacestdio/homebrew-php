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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc2689786fe5dd6a55c84734f9d94b9502281e0b014970719caadaa9887a8e66"
    sha256 cellar: :any_skip_relocation, monterey:       "235e1355f6d55e1d289064409ed47b14cac1f1d059cff21739caf961a818572b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "397fab2990267071ca6d3f40e41f017669df2c48509fcfc8a50a4fe5b518759d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "870267e4d49a8119f8ca8a958b6f4854953f0e47af7bc521763086828b7573d3"
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
