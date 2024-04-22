require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.7.5/mongodb-1.7.5.tgz"
  sha256 "e48a07618c0ae8be628299991b5f481861c891a22544a2365a63361cc181c379"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.7.5"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5c3380563d96677d534fb024152c21cd3637b6589b48ef5af14daec05b7eeb94"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "621717528f9b206212e319446493de92774aaede467ae44eaf02bd154ca60fe3"
    sha256 cellar: :any_skip_relocation, sonoma:         "d5062653b1a9e7c165240dad8ac62f25fe02e7b91fb9660957fb31b297c96a8c"
    sha256 cellar: :any_skip_relocation, monterey:       "53cbd0177faed19981136ddaf2c1d63a2e3994fbf058553d7358ad43c4b1a97d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3d74357985cb9640b48ac542e5f8324f9c4214840b46d24da5caffb8817a163c"
  end

  depends_on "openssl@1.1"
  depends_on "digitalspacestdio/common/icu4c@73.2"

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
