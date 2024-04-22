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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "92764ec8a633bdabcfb0295c21e185f9ccd10628b5345ef45e5de3d62de2be0e"
    sha256 cellar: :any_skip_relocation, monterey:       "4aa6514ca94de2cdddba01c24763c26d44bc4309d17a899af3005f78dc617b62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f662c4c9e068c488ef4ca49ac6c72d3eabbdc682419326296064364419a155e7"
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
