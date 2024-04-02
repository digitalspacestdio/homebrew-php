require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Tidy < AbstractPhp83Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4748217c8eecbd928716687320e997317db73290991fd7ec54aecac4cf312a32"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "068ad0f223bad812fef29632a84953104109271d1af40aa5a58414ff7d10a8bb"
    sha256 cellar: :any_skip_relocation, sonoma:        "5bf0ac6964325349f11b7f707f1ee2a0da9c1e967fa0332c383a784a26538ae2"
    sha256 cellar: :any_skip_relocation, monterey:      "eb2c5ad6451e6fc8be680b1fd81201082ab404d3434cda50f59d0ccb90492016"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f726ca24d13a586a603dd43d4c50c75352e977ee236fabc105847ef1770e3f02"
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
