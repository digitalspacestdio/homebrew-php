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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1439c829251fb0f7ae9bd0666830d966bdf94497d33d1dc3fdd331d8a49bfea9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "bef7c60b1085bc96192d8bbcc71ada7c361395dd085feb64b18d35471aa7b5f8"
    sha256 cellar: :any_skip_relocation, sonoma:        "a1bc19c32480b34f7f4edb6a594944289ff899930525e2852a5cf2336186cdac"
    sha256 cellar: :any_skip_relocation, ventura:       "67a1d5900e1bd4ace7b04e81d5c92addd2e570d7a8451457264668f37d419d8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1568ab9cb18e668d8adb5746d2edba0d34a31d70c81f7cf3a819cea45da4a78"
  end

  depends_on "pcre"

  def install

    pcre = Formula["pcre"]
    cc_opt = "-I#{pcre.opt_include}"
    ld_opt = "-L#{pcre.opt_lib}"

    args = []
    args << "--enable-apcu"
    args << "--with-cc-opt=#{cc_opt}"
    args << "--with-ld-opt=#{ld_opt}"

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
