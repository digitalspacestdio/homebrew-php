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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "813a0469890b1b7680a9944e6cc0461960f0dbc82ade46aae0e25b0ba73b12f0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "00d12f2c14dc9a2a07bc70cfc316748c697ddd7e8779e3cd02f6fbe2e5437ff4"
    sha256 cellar: :any_skip_relocation, monterey:       "d460a11a8593030947c8285c0b72a0bb4e25a0b819d08681d51fd450695200e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb720d67739e285b341b17543791491df61984fbf252b187e6f6786b2637f6d8"
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
