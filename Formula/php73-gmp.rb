require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Gmp < AbstractPhp73Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a57953be37eed1546d6b621cfa7909cbd0806bcfa81ef7fb7a4881e7834e5975"
    sha256 cellar: :any_skip_relocation, monterey:       "5eb4d2bba55bb31bdae3007218f8828821d23f966001c7428132e9d877277440"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "44386034628c76ae9ed40a902ab8a4e517be171438429a0b06723ca867ae6202"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "110edb7011f93939302937afb839ebf572a98b0384b3b3c5d1975cf13cc6a5a6"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
