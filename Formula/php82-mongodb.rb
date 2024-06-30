require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Mongodb < AbstractPhp82Extension
  init PHP_VERSION, true
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "213754aad4390b41388f068469cc5de141b25c9217bcff6696bd4a8031961c3e"
    sha256 cellar: :any_skip_relocation, monterey:       "608bcdc2ca2661e20fbd0776ad5249597995feb4f18525b64fbb8e0ec2e9d19b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cf4707636656a1e77317660d132df7b5f89226a5252ba210194f4d3d490a9502"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "215960d616e3b34ad762c86982c274ebab5be1cb6cfdeaa45402e40f0d740491"
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
