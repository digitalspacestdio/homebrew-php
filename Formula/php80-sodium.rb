require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Sodium < AbstractPhp80Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "911899f785a6ee4c6841093297ca35295cdfbdf01faa41871cb32b969c4a6fa2"
    sha256 cellar: :any_skip_relocation, ventura:       "5d2a15ac269021bdf5fc38c0d0db98d35f6947388530a48d358aca35582183d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1981515a5b1d1ad0ec04b06abfbfe439da26ebdf228a1fc683ba91119a67f9e"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

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
