require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Sodium < AbstractPhp81Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.1.31-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c01c46d192dcc54e62b01482db8f092d9ad36de58cb0d860509be7265d0a4dba"
    sha256 cellar: :any_skip_relocation, ventura:       "8eb637d982ee228a79e0342522ce737afc7c589f4101e88094445a41457599c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8bd81321a39fa8ba7fa7dffab37d03d0f54f2345e58e70c9829b3310489891ef"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "21a541c01b93e8ab4500d77de4b8e01ef87679c244b69d2e4aaa38948d5c3d56"
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
