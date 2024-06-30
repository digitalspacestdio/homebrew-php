require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Sodium < AbstractPhp81Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.1.29-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "03e48d7c163ae0c7f32673227bea4d15a488e2759edf317827cbde61731ab517"
    sha256 cellar: :any_skip_relocation, monterey:       "d082d9b75e373b9d007d84069b300d4c18d5ae5c2a4e39627c92629d56529a1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6bec85d1b108f61fb9bcead83a8801a146d0678d3fadb1c8e687384f0ecb8383"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "352cd273199d16a7867915b570d3e803cca321b81fc315b82834847fe4178209"
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
