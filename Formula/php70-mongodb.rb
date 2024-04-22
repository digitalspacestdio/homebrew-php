require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d6a91a0251773ad245196247f3c00326fe749457334c044c7166fa3fcaa5d3fb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "44d18df39b44da7835bef100294f72115424cdfa8d2070caefb4eb86bed068cc"
    sha256 cellar: :any_skip_relocation, monterey:       "1697133e878634f1f1107159f6d5d47cb6acc2518d1df9fc63ceddafa10c5b0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee240dc92cf782f5e6460ffddfe22298f23c6e50222fc4bd91c34603b5f381f5"
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
