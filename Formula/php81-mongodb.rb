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
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "db7bcb3424f7880d00b8795cd7a4ebb18d914ecf53310161ac80cd113d01cd82"
    sha256 cellar: :any_skip_relocation, monterey:       "0b3110a3f6f4cd04b4a0be0c42b81e0ef9d56623defeff8b889e3521c9de782a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "96266b1434fcd7359da45a180122f680a0673758c3cb290ad4dc51ab480003a9"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "6f0f189492961270e8b750d3edc481840bf55a507b8761fb48ae18ffd3183d6d"
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
