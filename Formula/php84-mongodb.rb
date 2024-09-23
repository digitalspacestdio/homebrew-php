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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "901f39f7eb3fec22adf49fb4c292aca92a6b1b6f87fc7cde1b9e0d5c6085bfa6"
    sha256 cellar: :any_skip_relocation, ventura:        "d37fc4c5ff89292f54afaf3f46003b1c63f591d999b5588b5c1e80436c5442de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b79abc3a90aabad6ff5b4d52fab0fddb2c888cf59cf389e6aafd228e68e1964a"
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
