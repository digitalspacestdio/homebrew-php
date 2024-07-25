require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Tidy < AbstractPhp81Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fba034f06a543c16e0dca490ba50bb4d960f18462c88edba3c92defbfe9c8d55"
    sha256 cellar: :any_skip_relocation, monterey:       "ce14e55b8a75800285f18a0b11d7343a00523affe74092c24818a437823cc77d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ccbb037298f5ba38f4746fab252a67d208da932dbeeaaeca04ce5085119d4f7d"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "8634aaaec059d9aca6a952442ec68bf0baae27485c5d0a37f1f8217da48c6ffd"
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
