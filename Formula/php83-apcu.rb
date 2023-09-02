require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Apcu < AbstractPhp83Extension
  init
  desc "APC User Cache"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.22.tar.gz"
  sha256 "dfd3e1df434fe84439da499e06d0857fd06dea5572df910d830b1d6474393b08"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "5.1.22"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b88028bcb8b8eeb0a1a59a581f0367b0ff39cc8459cf76df815010bb6d42132b"
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
