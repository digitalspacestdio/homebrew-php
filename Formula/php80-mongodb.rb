require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Mongodb < AbstractPhp80Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.12.0/mongodb-1.12.0.tgz"
  sha256 "0d9f670b021288bb6c9b060979f191f1da773d729100673166f38b617e24317e"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.12.0"
  revision 1

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "63c7df679c7e3e85c194d0964fba82ee8136a4b1fa66911faec03e2398537e5c"
    sha256 cellar: :any_skip_relocation, ventura:       "c590bc93a7dbb259ec9bc8e481de97cb1ad0d6f8c6274b6072625a2b0e5ed311"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b8f78b460bb15359ed2344015647338f2d07e52b52101ddd2e0926318b65ff7"
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
