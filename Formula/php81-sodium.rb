require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Sodium < AbstractPhp81Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "89e1851e79d68ec1cfe9dcdc510058a6d556ab1e3a7fb634061aed618ed7e49b"
    sha256 cellar: :any_skip_relocation, ventura:       "2439eb5ee901cfc5910b29bafb6b5cbb6d20d6e9ccc354030256aba6350156f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "96b5e853dbc41057fe2176e55fef963a7c1e00d988897fa6ab7a259720f94312"
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
