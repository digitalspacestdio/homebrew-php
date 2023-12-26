require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Apcu < AbstractPhp71Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d0286f03e4dcf435f9f08cfc47e0333fd65ae84274579b8edc57d1cae299c309"
    sha256 cellar: :any_skip_relocation, sonoma:        "f05a5fa8179e0db1a735a86ca913d4dcbaba12266f5a738c8f52550142c9c9e6"
    sha256 cellar: :any_skip_relocation, ventura:       "4e84d8262dc3f24691dfa1236bf0c86600a71d073b5713511ec9cde2cdbdb9b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "41c573db1b194525187e040c55a6309d8729f9004661c6efbd0427055bb49030"
  end
  depends_on "pcre"
  revision 2

  def install
    # ENV.universal_binary if build.universal?

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
