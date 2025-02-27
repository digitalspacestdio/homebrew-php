require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Tidy < AbstractPhp80Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "https://php.net/manual/en/book.tidy.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "72872e7aebdb8a2947cdd4c1bcdf6c8c291d9192271afafc041e01b7d2fbea32"
    sha256 cellar: :any_skip_relocation, ventura:       "20f1505bb3954c1e9ab0655de8472822a76e0d68665361147cc1ab9a02507e6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d54916ba733bfad06ee16e0849802960032f80cb84bcd414cd2a0f2b79b81a83"
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
