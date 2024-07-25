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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "00d545445968dc1ca3130b2da86aee2828cedcc5ee13e2cd15833f7363b8f4c9"
    sha256 cellar: :any_skip_relocation, monterey:       "db379c82a78e80e8f58cf865e947866be9e318b3e1df541c656f8c8d47b86d37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "32cabde63703612607fb7865e35d516b5a615e1ab36437d0277f35050538d8c5"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "1bf0b6b5a77e1ce71437d7702a6dc61ae900212f4aa6c867898ee002ee278be3"
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
