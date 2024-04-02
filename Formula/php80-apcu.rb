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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "aa47dc1f5aaa0e74724027e740d4006e41f10c20ca99fe70f1591cc7ed82ec92"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0b341b6065cbc47b92be45d674144d24e848c2119198bcb96cd8cdb0493d70de"
    sha256 cellar: :any_skip_relocation, sonoma:        "1d17c621b89763fd110b4f83a2efe00c3f4c1478e8b97b9310753aef2be8eb82"
    sha256 cellar: :any_skip_relocation, monterey:      "aef025635844fb3342ad9400d9506dc2212052944b443243eeb252b1a8842161"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "53ce50728830c3ea5b3e5f60f04b32b6172b591535a60efaaf00d1a6f819966c"
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
