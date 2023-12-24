require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Sodium < AbstractPhp80Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision 1

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e32b4c2840f21b1be385cb311832afc39bab74e42cf26e37a7b54c8565798741"
    sha256 cellar: :any_skip_relocation, ventura:       "b44baf933fc28868872a4e850b239457c4de1d86cfe09970763e641d331c9490"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8261f8604f7e928c16d071220a965cf42e157557048589b78fd3d2ffbf9f2080"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-sodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
