require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Apcu < AbstractPhp73Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.17.tar.gz"
  sha256 "e6f6405ec47c2b466c968ee6bb15fc3abccb590b5fd40f579fceebeb15da6c4c"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  revision PHP_REVISION

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/7.3.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d03e162bf09d198b296fa829b78fb169b12e347f6dccf9dfd916924405e89a80"
    sha256 cellar: :any_skip_relocation, monterey:       "20cedc1b2996e86f4491b6a9565dd6bf2bf68f1fac68debaa92ca13b752df05f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "27b44d1aefe618d6dfaa0561921a83a9bdd049087c26f3e37efa46db73667967"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "fd25c21f996787d9926fbc337590a20de446bbe4caf98a2ca79612618aea695b"
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
