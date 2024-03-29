require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Opcache < AbstractPhp81Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "13c68088e876e651642c35a8b38b5ff8d57c98d2936b3df6f606ce395e1ba23c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ac127aa8307b80879ec006d36d7dd8f9d0f91937061b2366f55e1f2d9a858f96"
    sha256 cellar: :any_skip_relocation, sonoma:        "6cda95c19e9e0e6517ad6bb1195c067ca300ecc64eb0d51e3d17955f315cf1fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "87ffd73a26d945b1153d66f6a387bcec8d8a896aed1d7ea74af2176de7c10f55"
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
