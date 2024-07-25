require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Sodium < AbstractPhp82Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.20-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6ff34a815d712119cad2952c630ed9d080c8195aaf30b508535db0e707faef96"
    sha256 cellar: :any_skip_relocation, monterey:       "2a192657ef24a68c5672068c327b94f64daccf8f38965baa31a2ec2cdfbf71bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1641e17b5e40efebbe616c577f5943fdaa727acbb4aa548b0aabd8bae433bbe4"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "5da381c22934bd9dd378ba442e9897b4a4589cce6190622299c01b2b59e8e2e4"
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
