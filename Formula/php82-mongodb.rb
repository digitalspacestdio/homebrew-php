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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7cb7ccf21df00b77902de6c7f0716d1ef8665c0b7bd4f90229d569668dd80512"
    sha256 cellar: :any_skip_relocation, monterey:       "c72c63e2eb6eb1a0650448a1dedc57c17510ce8cad6323162b1f72742d42868e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "774c713ac539501d73e3ed468bd7be233cec72bb8dfcde28f164b3c799c092fa"
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
