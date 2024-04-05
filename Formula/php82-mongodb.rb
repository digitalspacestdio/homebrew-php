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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82-mongodb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "22d02d25468acb4cc9a4f073438d80a780da65eb94de405166a9d040ecae0fa9"
    sha256 cellar: :any_skip_relocation, sonoma:       "c6e12b366af1e9ac9b44d73fcb14c9c80669f827336ee2a80ed6565fe5bfa393"
    sha256 cellar: :any_skip_relocation, monterey:     "99e387a05eee86c2a7e50825dedad0dea1d406097f251a046ef73f6d8152d46d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ae30a673e0b2e81b6e4d6403b839858997ccd1e04afafe2dff5e7383d451d931"
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
