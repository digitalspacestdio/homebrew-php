require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Mongodb < AbstractPhp81Extension
  init PHP_VERSION, false
  desc "MongoDB driver for PHP."
  homepage "https://github.com/mongodb/mongo-php-driver"
  url "https://github.com/mongodb/mongo-php-driver/releases/download/1.15.1/mongodb-1.15.1.tgz"
  sha256 "b2038e778d71f45cadb8c93a30eb548e5c2c1e4f832807a775ed516b7816b749"
  head "https://github.com/mongodb/mongo-php-driver.git"
  version "1.15.1"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d385730849ce22c8b09c39f9c73df74e9c2a0011fb8d5955421cc8a11aaff7d0"
    sha256 cellar: :any_skip_relocation, ventura:       "57f9bc8e3ccccc63d6542554d935e6ded8b704f965ce7572a3ef5b33234d8e05"
    sha256 cellar: :any_skip_relocation, monterey:      "3cfa18dc53f3f184d51b04d02d5696822ef1139fdbe3f000e47c90bc34a6a367"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e2285be1ed2b0c7b4bcff35172e2d09e8d50347bf43ff2c1fe14b41b93cebcd"
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
