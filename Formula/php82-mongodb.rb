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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3ba4853708c89a8e257ea837ba6bca61871d6965b05e7091fe87c781206abb6c"
    sha256 cellar: :any_skip_relocation, monterey:      "5454e7d1c3338491cae7b472b7fb29e696fb7860c4dcb0f8667dc0e64b5cb94b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a81f42d5c0ca1f6383b306ca795285309087acb3506463022d8d8b1f06e49d5c"
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
