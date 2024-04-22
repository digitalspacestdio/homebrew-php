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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ce2074ce7bf773ffda92c22afe01ee36f86b22011f57896e1129baca6032dcf0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6a5915458315ad0af84b3d7c6a2e4cf4004417b961ceb6af9e32c177944836d6"
    sha256 cellar: :any_skip_relocation, monterey:       "b38d9c7978489409f801bf8dc61952d8c108f72bbf151393f5cd63c4a53703e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ffc6862a81258687104318365aa66577364fa80eae5c4dd0ead1d05f8dda7080"
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
