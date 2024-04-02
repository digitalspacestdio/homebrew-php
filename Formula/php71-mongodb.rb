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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e1ea9c3590b52b57134b970c2473b5c0e54535facb2eea6627f10853346924e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "de20fb42ced9bbdc964782f7f69d1134911c99d5e594510f39bb2513bd8c0586"
    sha256 cellar: :any_skip_relocation, sonoma:        "75797e839193b2ab38538d7bd26f873e3afc6b2a07053905393a42ef73be7bdb"
    sha256 cellar: :any_skip_relocation, monterey:      "d82350fa1adb73efc40c42cd6c547ce3297de83f607b7a79c07063f3eeeddde1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a86da16ff44f94bc705b0781dec64c0eb66cd2117709e3d37f0ff603a8bb6e4"
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
