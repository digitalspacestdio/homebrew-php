require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "92775a6bea88b27517205d7a1841f247c5df11ead74db392e30b3592c2e6b3e9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "658f92fad807aff18e795e7a7d5b1632864c604a8eb72f7fbdb01e29324a0260"
    sha256 cellar: :any_skip_relocation, sonoma:        "638908cffe07a7fa460dcb8ab2f99889cb1ff552ce47dfa16d375b9f9c597e5d"
    sha256 cellar: :any_skip_relocation, ventura:       "5ebbcc5da5e82dd8489ccc6a366f9e716ea0b9f7aeb512ca6f38897f0b389543"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "033a5f88bc401605fbf2b381a823215c2334c6a887ae33a17d50cbfd1b558a9b"
  end

  depends_on "openssl@1.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
