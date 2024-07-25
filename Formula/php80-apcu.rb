require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Apcu < AbstractPhp80Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.18.tar.gz"
  sha256 "0ffae84b607bf3bfb87a0ab756b7712a93c3de2be20177b94ebf845c3d94f117"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "5.1.18"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.0.30-104"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1fdd4d5586b01005914566de060fbb474e5139752b7c63de9d4be37928c55517"
    sha256 cellar: :any_skip_relocation, monterey:       "9f36a97b786150f3bd9c71ccf04a69ed3358d53a688ada76339b0e97c723b1e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4120884a41f7a80b988f8934b7b2e64a27b68dd4dd2f27dbc63f9a5a7b13271"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "66677ab65b64eacc78fab0c78dcc5599db0ae1104a93e3e7bf5120e04ab21ac0"
  end

  depends_on "pcre2"

  def install
    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    args = []
    args << "--enable-apcu"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/apcu.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      apc.enabled=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=1
    EOS
  end
end
