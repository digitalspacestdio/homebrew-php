require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Mongodb < AbstractPhp80Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.12.0/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.12.0"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "08df4942cc7269311613f76c59c9763c3516a90626f7c2403ac780f2f37f33b3"
    sha256 cellar: :any_skip_relocation, monterey:       "b6738d995d5ba2db6931f6d39d4d453342debe671287c8e54fdc7ad2171e0133"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "694e07e023c6218f242ea32c50bbc0ab7247a71280b01e22bf18f0e8ccf879dc"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "4af713db519f32df64820bc04e79cac71ab4699b69c6c6b804323199b15baff5"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@74.2"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@74.2"].opt_prefix} --with-openssl-dir=#{Formula["openssl111w"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
