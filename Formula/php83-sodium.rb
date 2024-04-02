require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Sodium < AbstractPhp83Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8060eca10707e40099053ee8ea5a08370d086f0c0087687408bea96630998774"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5877c50131a4dc353521f8291f98b9df7b8687cad1a7a5cd72c6633768f8cfa7"
    sha256 cellar: :any_skip_relocation, sonoma:        "a9b10dad4514235181bb0d78f692b4f81e4a3807aa60f777ade9d0aa31ebc75f"
    sha256 cellar: :any_skip_relocation, monterey:      "49b9374a7b86bc54d52d7c6ab12bbfd9a42d11ccbcf5748563e7390f661c1d85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3babdd3856e2ab7f443e25533f145236fe85f00b304d6654e5a2bc2acb416aca"
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
