require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "916b95d49a4d362b3dba2d4f629c3f30c1d52e7832f32feda7a2dbc1ec211228"
    sha256 cellar: :any_skip_relocation, sonoma:        "ad466742d4d2800dfe34e9f8fbd86f9d6643f668e1b934cc0353a08ff015170e"
    sha256 cellar: :any_skip_relocation, ventura:       "132b0e140225555692fcf9c8199c704893ebbad8254e9199bceb7467b42d0226"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e0b186d4461803f69b384f267a2d797e440a7d8a8f29f6e3acff868b0d0cc96"
  end
  depends_on "openssl@1.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
