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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "115bbfe43d91b66f24671a874d751007a8e8535a094480760b418255bd953606"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6d4235a4dec7864e9006af5d7aaa3b2476e14a1722766696fb8955de73155917"
    sha256 cellar: :any_skip_relocation, sonoma:        "d0b8fd70f1cae45f576fbabddb91b6c316ce93915ab0dc290558a5df7d2840e8"
    sha256 cellar: :any_skip_relocation, monterey:      "0fa5c57480d15855295114b484e3f3d329bc657215b61da9dc1898a819f602ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0324dcacfbeb7d85f05d31db2285250a1a27a701db103eb27649055ba0b4b76d"
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
