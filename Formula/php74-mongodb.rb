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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "69337f6693f8a056358348adf4b8d8eb66b19930f454c1cb1ca14568dea44529"
    sha256 cellar: :any_skip_relocation, monterey:       "2bd8dbaddcf4ef4c89ef86aae4fa1295ed9739ba6bd7e430b7725d15dbd38a1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "400d57a259a40b59496acd5179f9f8aa7430a06cee3bd79e07d2ae2e4ed5e169"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "c8e9c29bb5d20dbdc4b20a2003dd5f9f5c000d438adbbe3bbcb4fa4491ab6988"
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
