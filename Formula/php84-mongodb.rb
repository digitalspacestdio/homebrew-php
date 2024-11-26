require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Mongodb < AbstractPhp84Extension
  init PHP_VERSION, true
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "6013e3b8476b3724061f1399b2d8c066b90375fa94c88681975c5ce8d9bfca75"
    sha256 cellar: :any_skip_relocation, ventura:       "93d72bff4752d554d8a7740b27c01f9779fbc0781ef4c713051d05d33ddab35a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8cf6fcc52cec3dbed180a4160a86f37cfdf25c5e0e0db6e5ceea2a7d0676dc2e"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "ade7246350ca00bdbeadf0086037db0cb2dfafa00c40a833fbaab1cb3005d9f4"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@74.2"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix} --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
