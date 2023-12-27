require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Mongodb < AbstractPhp73Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.9.0/mongodb-1.9.0.tgz"
  sha256 "1a9e7117b749c2dd63bd3493bf38c24a9acd11646ec96a0d92ba6380eee0ab9a"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.9.0"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "264de1cd4e1e6e72e812de736a674a5cf803b5d04e48d630f4998f0313332551"
    sha256 cellar: :any_skip_relocation, sonoma:        "16af49b4c916ac8702a6dd60fca89db2536a291d851b2ea2804e1b13c97fadee"
    sha256 cellar: :any_skip_relocation, ventura:       "33a1ab693bfb45ac317506efde4c4686fc6832820ce07bce1f6abd1c3a47a2ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7f522c4ff96b83af13f06d0108cf4e28666e71de0fa320f88caa60af4ce491a"
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
