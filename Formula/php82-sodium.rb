require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Sodium < AbstractPhp82Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e34e133950eaf8f597e872b50d0050fea793370599cd47c6750667a59006cd3c"
    sha256 cellar: :any_skip_relocation, monterey:       "7497533169a974a44c63d3e3ba90cb93bbe3ab68e4924d8a151aabe63787ab18"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d79a162c9d49cdae369841fef7767aaf177c7d08cdcbc82313352aac9f48b30a"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "706c9be3054076a5eba5319a7c6fa3c3504de2f2bdce8964b980e0800153c6e9"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"
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
