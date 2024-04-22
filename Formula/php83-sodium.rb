require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Sodium < AbstractPhp83Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a19bcc2fd4b17d6e099dbaf363e0561dbfe5dd1f570c85ffc9ca99b5f16d2084"
    sha256 cellar: :any_skip_relocation, monterey:       "e22bcc7e1a5e00d775ea16a0b63036647c301eea67d68842bb821003cbf91417"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1c1a7490a270edce4e3abd82fe16fd9dae0d5b4a7c10ade34873526033bd38ef"
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
