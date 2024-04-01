require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Sodium < AbstractPhp72Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a856c2d12971f81737b56faf2542958b3b7850e3af9e000a06c18712a81118ad"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f1a85b66764fbb143c123bab6f57c23d7407dd6be40942ec5a3c064f3b1ee2f7"
    sha256 cellar: :any_skip_relocation, sonoma:        "7c73c9978f998469fa6246e09f0f0dd8ddbb91be3a6d22a15794924273b57d08"
    sha256 cellar: :any_skip_relocation, monterey:      "91d199497aba01d5b78e66518b9188703407609fbf8abbbf1a684fcc74ba743f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f2dd239ce547f72c956f3a2250fcb8bf0b132359c878c16d9ba44355a9a549e1"
  end

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
