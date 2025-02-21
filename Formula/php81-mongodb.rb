require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Mongodb < AbstractPhp81Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.15.1"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "12d84def8c75d1a4877d763a6efa780ecc78ac50d9472e14434a5bcb9b0e3198"
    sha256 cellar: :any_skip_relocation, ventura:       "04d2fb537b1149171c3af86b1d3d9332c11fc4bd4915c9e1a4a717b73615a5ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4985775c63eb49cf85d7551bbffa0a7a41de90d60b6385db75674614656a9a8"
  end

  depends_on "openssl@3"
  depends_on "digitalspacestdio/common/icu4c@72.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@72.1"].opt_prefix} --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
