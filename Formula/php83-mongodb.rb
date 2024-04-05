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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83-mongodb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5ec94bbc085417e30744b9e4cd5b9bfc2cb45c592939d8ae3f1677560bc6ef28"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ce87d2035515b7e76aa9668f020f345b607b929164029b35bf88201424facd10"
    sha256 cellar: :any_skip_relocation, sonoma:        "770bd88e37c9f74625ee45da187044a75e9ae5543d7e8bc34b7e98cfa1a8177b"
    sha256 cellar: :any_skip_relocation, monterey:      "198ec3dfb0c997935363e7d3bf276fa2ff82a74d7d922046cf5969ca09d2cfd6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1643ceefbe153c9885a142a131a3d6769e30f8a9a733de489cc23fb5e87f1016"
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
