require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Tidy < AbstractPhp73Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b71842da0e3fbf400639b0a93e4a29fd50d8ea4b1a3b4d77c0618f4b922b1813"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0ab9a9da555765f62a878c4ebae3b2f81f35b3f534eda034a8c640a6e2c540bf"
    sha256 cellar: :any_skip_relocation, sonoma:        "ddc423562302a3fef74fb37af127647f448aafabe921a7c255e4b15e7ba00629"
    sha256 cellar: :any_skip_relocation, monterey:      "74a6de421156df37a653fa65012530eaf0061db612e7a1d69a1629d5abd9766e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6fbff0a00ed31537585598846d53ff4012b3ab3a770c9cb46cde51652331cb31"
  end

  depends_on "tidy-html5"

  def install
    Dir.chdir "ext/tidy"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy=#{Formula["tidy-html5"].opt_prefix}"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
