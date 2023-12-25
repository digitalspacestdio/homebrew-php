require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Mongodb < AbstractPhp81Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.15.1"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e001ce2d0e4ad909dbbcec962c0955ad660ef1c2af281d448b2cc4d699a45fe4"
    sha256 cellar: :any_skip_relocation, sonoma:        "5233594492028b04258b90a59ef3b140e1f5ba8ca1152dbf233000396a9732cd"
    sha256 cellar: :any_skip_relocation, ventura:       "a5a49b294a89d782ef73f7df83bcfbf2c56457d800b5cd8424ac542288eaab0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10d8b430cb71a0a25bad9abc16136c6a89212bac3148d49be1a084a12889891b"
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
