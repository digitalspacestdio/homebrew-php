require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8c9352a9c102fd03b675fb2ee86dcde7e1ac4fb590a6b7e04af0c06ecabf9bd9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "819a2166f7f1c66245140408dee5b28847c2eadedf377044eebbc0d6c6788f1d"
    sha256 cellar: :any_skip_relocation, sonoma:        "82f3201201532a41cb828e915eb7898e07df5fb711c8542a309e0f701fcb7733"
    sha256 cellar: :any_skip_relocation, monterey:      "2562189df228f82301370457894def5e04f067d1bf75992e43ca9454ca3d677f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a86da16ff44f94bc705b0781dec64c0eb66cd2117709e3d37f0ff603a8bb6e4"
  end

  depends_on "openssl@1.1"
  depends_on "digitalspacestdio/common/icu4c@69.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix} --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
