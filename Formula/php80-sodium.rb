require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Sodium < AbstractPhp80Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-105"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a10c0d3bd647dd0a7469ea4b0a42cf7fe4e50bce3fac2022ebfa661fe551384e"
    sha256 cellar: :any_skip_relocation, ventura:       "c73dd5eed5c5a547958b384ea906fe8e2fe672574dc01e8d575b5f648d857227"
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
