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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fb4befbf2d8cb360e745264d6fce5d1988e39750ee08b642d8f15f06322b2ecb"
    sha256 cellar: :any_skip_relocation, ventura:       "6ee03b35ed25e1a2bf430185d8a106bc1876aeda79a658e13a26b5b1dafebeda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b815a5fd2c0a9b3213786fbe47884d12dbfe4539e29e944059d3de7423e2b469"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "e2f5cec19643e1ba8391a837856866309f70402e980923fbae50721eb5d23e02"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@72.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@72.1"].opt_prefix} --with-openssl-dir=#{Formula["openssl111w"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
