require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Opcache < AbstractPhp83Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7285e3fb0d8f6491b19894596323ae62ff421fb34c9106cab884542e9c3c9c33"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "96f5ab9097be954dfa06515148bc9b2dff61a9c4293ea4c59e4fb0063ab9b6a4"
    sha256 cellar: :any_skip_relocation, sonoma:        "a0f96cc73b1e44b5c3a041a1fa7d63ca2aadf8e278236801462d7e703d2b8587"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2484f96d1f9a54b8fa614ea83dccc18b85281691852ef367384192577d138847"
  end

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
