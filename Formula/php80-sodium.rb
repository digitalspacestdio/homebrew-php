require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Sodium < AbstractPhp80Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "96fc12454f62fa20321c22dd3a6eab80948826e4c877fcf05499f45cd19da12c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a582099d73492addfb5cb07f6478a2f64550e8692370bcffaa4645042f61d538"
    sha256 cellar: :any_skip_relocation, sonoma:        "029a7d6aadc8beb82d17bea6fe5d9d1b65cd2e9033a8b1c13272376c74c55226"
    sha256 cellar: :any_skip_relocation, monterey:      "201d968fddf366f3e3d1006758c37ec176a007ca5b0d57e93c58f4a0ecc181f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3741b11be57a2dace2d01f85e85d796d5e2687bfad70f2a589fa382549b4d28b"
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
