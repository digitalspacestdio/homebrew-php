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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "8f6dad435a8003654cf13bf3a53a20d6c5a0106d9bbc988ab6af28d4561e62ea"
    sha256 cellar: :any_skip_relocation, ventura:       "f85ff683f9313bdf13a6ad338cbbd37558216e92d7eb5bb6fa0abf042a697bf9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d9b05a51cba41e3bcde5195074db77544cc974b626ad91b0e3a31e1b704900d"
  end

  depends_on "openssl@3"
  depends_on "digitalspacestdio/common/icu4c@74.2"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix} --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
