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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.2.34-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3786ed592d38efc8ee6f1cab83aa48c82f7cb0bee580a6603e25de63a93b62e0"
    sha256 cellar: :any_skip_relocation, monterey:       "06ca24ab6f897ed8cd615e8bbcc8af6b76341b4ed5037eea56c63db3a3e115c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f8aab3f5046c183e2fb378301256adf3d0fdeba05d883ce304c9037bae3228eb"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "f9e0166f4cb2a245457a24b41d7337e48c797d45b63b259454d20238ae1b388d"
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
