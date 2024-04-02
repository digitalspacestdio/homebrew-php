require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Mongodb < AbstractPhp83Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.16.2/mongodb-1.16.2.tgz"
  sha256 "d630cf32a73b6e5e05d2806782d35e06d24b7d5c83cfec08239549e6b6a600b2"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.16.2"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0ef48f2924219007246f0e3ccb20a9b66d23b94ebd82b49efa4d3460d1fd515f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9703e108a31aea8406b35dfb79fdc7ad1de349a3e6141c12e868fdbfde16933b"
    sha256 cellar: :any_skip_relocation, sonoma:        "5e93a10a0b55aa68988a5bdc9c8129c4bdba8b790019ecb56a72be431df94dcb"
    sha256 cellar: :any_skip_relocation, monterey:      "a5fc7c134566bc3fa7904e5e7d4d21276c2b869fb4cbf871c0408f456a2f7065"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa5316d1c766b3dfc833646e47f9145f387c6924ad32bf57cf0d5bbc309fd4fb"
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
