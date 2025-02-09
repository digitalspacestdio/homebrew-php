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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.26-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0f6b1f8bb8975b188fa83766a51a92423f84acb594947e1583c0dd0af1bd8736"
    sha256 cellar: :any_skip_relocation, ventura:       "609745e4ee4f7eec03cd3800aec7927060adb6946a1b0c4137800b03b8671cb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2cafde464e89e8b662587f5e71982594e5c5763dc5aefceb21ad592881991010"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "1e940d95cef17ec35c818edde9f041de4b8a77429c952b637cdf1dedf29c84f9"
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
