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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c154fd2eb05b5b52ca407514ec416251e3aa9ccaa3a639ba95d37dc6f68329aa"
    sha256 cellar: :any_skip_relocation, monterey:       "66dcb0ec647660ec6983e1a394a6d615cabb701a72eadfb6041c11ffddad7052"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4f5a42c4833bb274ea65ceb34386e67f22a7b9f1e31bc2d88da460527059ee4b"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "93b4b34baeaec1be6b9e0274fd6a95be87cb149c5d3c7c25aa9f94ec66a3caf3"
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
