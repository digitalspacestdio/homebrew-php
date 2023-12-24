require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Apcu < AbstractPhp82Extension
  init
  desc "APC User Cache"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.22.tar.gz"
  sha256 "dfd3e1df434fe84439da499e06d0857fd06dea5572df910d830b1d6474393b08"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "5.1.22"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d01244ce9d7944520bab2d95a8f7892b2cf61cac3c827287b3e24bdc0ef1dbbd"
    sha256 cellar: :any_skip_relocation, ventura:       "8ca1fc35350d59c970ef98929bbde607ef791d5119b1c227d3ae3f3eed25625c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "be3e297a9bf18ce56448da609e3637611b449490a05bdea446237e9154be2538"
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
