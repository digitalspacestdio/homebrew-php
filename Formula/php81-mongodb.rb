require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Mongodb < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.15.1"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7c9163e7cf05472ae0f7013c042659d7dc95f1a222b47eea1df313edb0def882"
    sha256 cellar: :any_skip_relocation, monterey:       "bc4c9f081fabe09f42f5bf4bd6aa856f6eb437e8cb8e833926010d354181e602"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "350e80458d7eee58e6df856b64997f9da4c8984d32e9d27b02ba0cccfc884615"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@72.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@72.1"].opt_prefix} --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
