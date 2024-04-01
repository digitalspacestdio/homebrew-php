require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Mongodb < AbstractPhp80Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.12.0/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.12.0"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7acb11d3c77fab65961cd229648adfd712c5a12b6847a639d6fe92fe0feac88e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "64054b12431ea8d8b60cb92748fd77e933bfcab261421e710ea99d6c63f656ba"
    sha256 cellar: :any_skip_relocation, sonoma:        "602e1cbfd041457468c5a51c716aa215e9b7c13f821be82a2d9ae5707ea69b55"
    sha256 cellar: :any_skip_relocation, monterey:      "b0787f44da1c4404db4fe675bc4d676a868c909b3d1c3b4cfb31b0e7d5f4abbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30c3a378a1307e3070ebfb025d8586b08958cc654acbda1c2de9fef519ff5969"
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
