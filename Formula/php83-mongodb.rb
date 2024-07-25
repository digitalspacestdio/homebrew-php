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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f8f5661c24ca3f997b4cec777ddca518c70c219312fcacd667fad55c163ed958"
    sha256 cellar: :any_skip_relocation, monterey:       "cd58ea37773493cf7d96020d6b97d3e0af4adec6297041c497aa9e6964232e35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "41720621bf7bfa2b1f92b0ce522610591c934f38422fe8df05e865cc944c978e"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "309e6065a5ce6d545a9ee0743d683b5b90424424553e4e867c47958c44201ddf"
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
