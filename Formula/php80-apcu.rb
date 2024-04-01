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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "de2aadfb2c66e6938f92ecbd4a8e8c52dd6a118d44cccf0ec9a928bc21830bcc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5ffe3952bd1a17ef803b2bb2fdedfcc0bed0611faf2aa89c4c1ecd92d91cb75d"
    sha256 cellar: :any_skip_relocation, sonoma:        "7cc2617150ce83061ac586caf0ae205122ee3692ad52b1aab551d5bab705321d"
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
