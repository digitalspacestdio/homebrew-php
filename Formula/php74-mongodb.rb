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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "465e1f634550eed7004b2505857283ddf188a1e07a3eca3907f5b329caf3108b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7da62cba6239e75955f65863fba8c8d61b4e0a9147bae8dc0f0f589b96d7de6d"
    sha256 cellar: :any_skip_relocation, monterey:       "19f5ed479238720653c06bde2ee622c0db982a30b52244e22a8be89925e43001"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5d21f68d65f7c9749c767fe8bf8d232dd7adb66592ff182751e5a8c3870537a9"
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
