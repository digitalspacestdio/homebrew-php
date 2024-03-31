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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7d7223d2195d145eb00b49ae4b10a25b0174eaefa63b740e00335eca65ce3c5b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7a59cdea587e7ab156e7cda60ea4136c6ecc33134e52992948f780c1f877ed55"
    sha256 cellar: :any_skip_relocation, sonoma:        "5233594492028b04258b90a59ef3b140e1f5ba8ca1152dbf233000396a9732cd"
    sha256 cellar: :any_skip_relocation, ventura:       "a5a49b294a89d782ef73f7df83bcfbf2c56457d800b5cd8424ac542288eaab0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "62e438d0e6756226b12aab461b7a4b951ee6518f61aead2b5559c3bf3a6aa832"
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
