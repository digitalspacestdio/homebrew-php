require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Mongodb < AbstractPhp82Extension
  init PHP_VERSION, false
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.15.1"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4048bad0a04b970959294a57620eef9da224dabf699e4164ab68a44b8af34524"
    sha256 cellar: :any_skip_relocation, sonoma:        "cefdeb65f0119c9b552db931faa7f96fc05241bccc9f5f46cbcf8145bfce930e"
    sha256 cellar: :any_skip_relocation, monterey:      "14b8fa136fb405e627d2422aaf8b7e14a4c2b7b8bdb3e2848eb83d8e00c6b4aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "35fc9eb460b05509ea62827e916f20e8f26dc7df1d97e1757957a802fbdfec38"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@74.2"
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
