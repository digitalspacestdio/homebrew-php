require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Tidy < AbstractPhp83Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "65952f788dbeec8eddbb9291269e726b3f83325fc641e20a18f73b56269ed032"
    sha256 cellar: :any_skip_relocation, ventura:       "6b5da3ef92a2e5c20e53e4e77e47f303740b08a5a31f1dfe263fcc4ebaa3382d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "24a15c4ab747e8c78051596547c3fbbb6273739204320a8ca473b5c2cf14795c"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "4f06ae800924239edb583f7bd6c5cea38447d84141851dd8f67f0c2f4b594a10"
  end

  depends_on "tidy-html5"
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
