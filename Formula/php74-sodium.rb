require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Sodium < AbstractPhp74Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.4.33-105"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "06a9d0e1946f6b681e51f7210a2696f970b29886e5ac0e81f214490c5d0adef4"
    sha256 cellar: :any_skip_relocation, monterey:       "83142e65d0b634f66ba7e254079c657308e9a7fa07c6706c590ede7504abde3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "18daf0120a08bf37bbf5f91cc3e754e929346125bb82e3e2f118fcfc6509517b"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "a610c6e64f3c589c1b15368da57a965c8028901222d1ef2a150fe913f59b446a"
  end

  depends_on "pkg-config" => :build
  depends_on "libsodium"

  def install
    Dir.chdir "ext/sodium"
    ENV.append "LDFLAGS", "-L#{Formula["libsodium"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["libsodium"].opt_prefix}/include"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-libsodium=#{Formula['libsodium'].opt_prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
