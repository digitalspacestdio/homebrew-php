require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Mongodb < AbstractPhp82Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.15.1"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dfd58adf6b44687f6fdbb20506ad760a5fbc5c98622f0d7d845364d879e6743d"
    sha256 cellar: :any_skip_relocation, ventura:       "afecea0ac70909a6c026b4a5ed6ba5a0160a39e382cadf6b9c75ab98745c6e63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "886ff7f4af76cc52122672184d8da5c3543aaafdaf7bfd71a28739b0c1aeee2a"
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
