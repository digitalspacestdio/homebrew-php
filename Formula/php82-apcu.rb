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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f04428394210958b39911c91f9617bcdfe3913570e6333529f454a5cac6534bd"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3b2f3da03d04894441eb47d9d4806b9deb9096c82db6e1844529690b00d7aa59"
    sha256 cellar: :any_skip_relocation, sonoma:        "9f78e1614e362770129f76ba74c96c51e05799db1b3691ed178a1719d5fbac02"
    sha256 cellar: :any_skip_relocation, ventura:       "8ca1fc35350d59c970ef98929bbde607ef791d5119b1c227d3ae3f3eed25625c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2fb475424381b02e1b664bcfa94ab05f9d6b82ee92ffa3b98352cde1b1db02a0"
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
