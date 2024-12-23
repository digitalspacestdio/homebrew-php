require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Sodium < AbstractPhp84Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d6d68a83681c188d914ee2d6c703fe8db897289c8bcc980ba0680f582e53cd4e"
    sha256 cellar: :any_skip_relocation, ventura:       "8616be28451358bdc0142747c7cd949d7aa4c042bb7a5273da7b771f3a15cea3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b4fb6b02981d978269afc153fe19ceea54b981d36631eb7f3a18ea2db67e14e"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "36c1bcb6bacbce279e521f0f374f720aa4a41e5fbcfe5b23ca5790c0b985bcc5"
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
