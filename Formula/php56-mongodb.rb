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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "ceb37b908d6f4fed3af4ac65fa0326d5ff0d126cedcc592fe0b406b82df7d7da"
    sha256 cellar: :any_skip_relocation, sonoma:       "846ce503faf8d510b690d6373d29235932214ce12059ae841c037b152abf0fd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c218e9c86eebcd0e5215a2296b149dbe704a8c2122c5c22b5c05bec1446b46e"
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
