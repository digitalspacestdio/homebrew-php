require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Sodium < AbstractPhp83Extension
  init
  desc "Sodium core php extension"
  homepage "https://php.net/manual/en/book.sodium.php"
  revision PHP_REVISION

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.3.9-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4315a7c29d0fc58c3ffb2e3b601bafac63be6e3237056199504679f5d0cd0842"
    sha256 cellar: :any_skip_relocation, monterey:       "5c609b28e875b3b13ecb3e6a2a2b61b84474352e1b9551e954e65482b45dd675"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "502259dc2ad2534222c6fceb897ddedd8220385499036d960637c1a9f1219c36"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b3c027a5ee03768ce2a69a4a61bccf73e633409de41a1f2228aff06cf8af621e"
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
