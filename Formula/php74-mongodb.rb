require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Mongodb < AbstractPhp74Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b942960fdb42e562ab39625e50bb70f13863b768f74834aa71769e637323842f"
    sha256 cellar: :any_skip_relocation, sonoma:        "6282c38812e586a6ac5fcf22636f3cc00d9b9952b92f260c984211aa4a2ad54a"
    sha256 cellar: :any_skip_relocation, ventura:       "97b768588b8c506b54a7aa52cd4c6604db7bce9faed30599a54246cdab24be90"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "366f3bfb6092f701b3db743bfa37ecab1a666d40df1902cc4255a30b79c0ef1b"
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
