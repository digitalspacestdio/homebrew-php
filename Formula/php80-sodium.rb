require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Sodium < AbstractPhp80Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "00e054a8808163910e92e2eb8f9f520a3cf69421f0b1edbb4c50ac94b7f4ae2b"
    sha256 cellar: :any_skip_relocation, monterey:       "67650e95d64d6010b3b6aa69822f8fec7b4376270272534e75299a6056b513b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "03671d2edeefaf55f20e6cb1889a6490016bc16cd74f046d20b12f5f6717df7c"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "cf35b9f4cb6e436218d67ded0bb87631038089e2d73a98c2dede318bd4612065"
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
