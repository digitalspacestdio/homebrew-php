require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Mongodb < AbstractPhp83Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.17.1/mongodb-1.17.1.tgz"
  sha256 "34b7d0528b5c3f2b9b7f677294ad7aa7822bb704ba6583bae99f2bbf79a29be1"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.17.2"
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9ad6c26e65336df415b32b8efef9c8ed5e0af893530ba3947edcca089edef2f0"
    sha256 cellar: :any_skip_relocation, ventura:       "609a9d4102c39fac30eba50a42251e975878e0edb9e999ca726af32e5ba6340e"
  end

  depends_on "openssl"

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
