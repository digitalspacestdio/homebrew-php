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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1fbe92ace3d7b3eb90a02ac6fc1be949a93da80691c7f7af9735b3b6c5d309e2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "94299f50da68c188407573a933bf7e1011c37fa7e8cf751e00867ce6708b76c6"
    sha256 cellar: :any_skip_relocation, sonoma:        "c6d5ec33e19b9988655b9059655a233a917837b30c37b69ef5fe46c6c333e54c"
    sha256 cellar: :any_skip_relocation, ventura:       "c590bc93a7dbb259ec9bc8e481de97cb1ad0d6f8c6274b6072625a2b0e5ed311"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a0ae764b99a793602c3ed703aedb5803c22f8b4d96a395c3b4296f238d891678"
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
