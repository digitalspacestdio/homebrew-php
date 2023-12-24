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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a7478b2e353f6a3dcf0a77c6ee8262f5e9e34c97636d6af2a676ed1541d2693d"
    sha256 cellar: :any_skip_relocation, ventura:       "5ebbcc5da5e82dd8489ccc6a366f9e716ea0b9f7aeb512ca6f38897f0b389543"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c18150d7e3e7b220d2d3d22edd5f9bee51d900d57895f622ce29f618da1ad943"
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
