require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7661fff64ccf615f90933cbbf3184c095dfcdb399e1ba5d785ef733e53562b8f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3709c8c64979626ed1fc1c117f929daab0974e08ac1d0e3479ebc4bd83b38de4"
    sha256 cellar: :any_skip_relocation, sonoma:        "3e3f6d30068dd99ebedc99e3242d30ec85e871b1f824a6ad9f90c60554980631"
    sha256 cellar: :any_skip_relocation, monterey:      "ffd47fbdf8d314460a421b8f08e2d6f7e0f6b27ad39baf42b5672db561e1c290"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc7f9bb62c44e65e553a96e34ce6bdc4b22fe66e4e9edd07d1797cba6471768a"
  end

  depends_on "openssl"
  depends_on "digitalspacestdio/common/icu4c@69.1"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=openssl --with-mongodb-icu=#{Formula["digitalspacestdio/common/icu4c@69.1"].opt_prefix} --with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
