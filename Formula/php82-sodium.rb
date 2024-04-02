require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Sodium < AbstractPhp82Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f6c6d32cbdcb2033fc90610e0d44dac2a2a63765d9e2356cef1fadc0bd7c65d9"
    sha256 cellar: :any_skip_relocation, sonoma:        "89140a3ac904af49e93b2c5658c5dc3a47431f7599af68ecc7f9ee09e18ffb4d"
    sha256 cellar: :any_skip_relocation, monterey:      "20bbb88c2f18410716c5cbd2bbfc8305fdc1dcf326425f5dc9df77ee9776d419"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f01ec7ccecbe9c23476c797a318cc71a8af74aafd7007a8e3673b411976bb2fa"
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
