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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f202c64f5498d2e6f887c7655a0cdd6a70128aed6164860d8834442fb04c17eb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2cc6fa9f9f77dfedcf6fb561faf1b041abbea946c8c2f05f8e5f9e28d49127ec"
    sha256 cellar: :any_skip_relocation, sonoma:        "75781f80eaaf64a15bbcf8454228443872e99df403fa80a0e2215634996eea05"
    sha256 cellar: :any_skip_relocation, monterey:      "ace4d6b7eddbd3ba3bf028b5abaeb969e6437bd96dd883ab34297cfc48bbba83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6a36f51c46d03e6251e9199a17af43170f0ed8486a0cdc521efd8a825fbe3f56"
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
