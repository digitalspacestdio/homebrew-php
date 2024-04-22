require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "56a98ee419346dbaad7a6c54b0483ee420ecfe4778b349090d6faa8aef3b6911"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "803900495bd876c46b079a11042a312ff660cd2b83bb0cfbf1900d3e011017ef"
    sha256 cellar: :any_skip_relocation, monterey:       "cd7a640140ebf5344d34d2b57b5079391dcdfefa90d2ab63c83d5b1f408db1e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "56e471cbd174027568dbcbb5b5008e63e63e8f822cc09a35e9bb14a420499449"
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
