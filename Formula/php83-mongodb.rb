require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Mongodb < AbstractPhp83Extension
  init PHP_VERSION, true
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fd1ff356c6a6c98b57cc2121870da3d6517bc776a8cc9b5d771b59fa222de4db"
    sha256 cellar: :any_skip_relocation, monterey:       "75e3991a0aa1bb7f759580b1bd6aec7c545aeedb9babc944f21e3e24b220ee95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "815ebf7ec8fa7d7b9f075687de73c2bcb43cb884a9365830372ef8eeb7d56919"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a82d7afd19f53500bb6cb4349a61b38959ea2ce60c630b72b3595fcc836b30e1"
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
