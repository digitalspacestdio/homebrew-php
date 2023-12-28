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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1b15f33187a846b769e19be5a20704d484426909c5f347262599c01c2d606348"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "19d3d5c8b3dfda804db95b65c1aeb2497122ca97fcbc6455abfec633c2695d5e"
    sha256 cellar: :any_skip_relocation, sonoma:        "42e40060f700cd1d7ce6bb249750da6e977923f9c17f3e30ae38322c91916491"
    sha256 cellar: :any_skip_relocation, ventura:       "dd7c3d3072d30942eb4ccc1931965bd8cd98dce65df8540fdfba7df5dac0f3e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c812b1a1ea0f7a24d90171ac061586b8ebeebb988ad5b6e3b7355919b3185ca"
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
