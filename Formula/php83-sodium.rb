require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Sodium < AbstractPhp83Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.14-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3593d296c791362632c8cee19dfe4ed48750dbc914e025f33525674882d0e5a5"
    sha256 cellar: :any_skip_relocation, ventura:       "8b1ebb582ed1a8a25673954515b0da0907385280bf474f153e2c2ce73f12213c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28723f28eb7a40a59fc05ccdaeadd943eafaf95a61f8186230e4ac31e96799ec"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "52d692eac7365ce4b18f9913b1e728e260d8debf99bc92ad21babb572e6b5968"
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
