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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0d73f3cfa82c63c57af67545f84d4917eca50b3817ec482aa221100a9582697a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "408717f6ef2e8c5d1de6d523963945f2799af569a3f19919b40acbb3e59f5a41"
    sha256 cellar: :any_skip_relocation, sonoma:        "3d526ffa7a96e09dfde85be4732f00af2233c40c90cd275bd37248b8bc1f7a12"
    sha256 cellar: :any_skip_relocation, monterey:      "226b893129354a5b56ca69be09c6edc0adc889044cbda062b0a08c69fc16e161"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3cb3d9a790e042f25c278ec7d9b2369bbd4b414c42d0cba384e4d935b27e4b77"
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
