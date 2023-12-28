require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Apcu < AbstractPhp72Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"
  revision 2

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "927ab57429cabe13d0d550f03f41354cdc8e4e008b46fc2ea155def12cfdb084"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dc0d11a2c65f4990ce02eb4626d0ff819ca69d2f83c7fdc5c16db5f896480460"
    sha256 cellar: :any_skip_relocation, sonoma:        "6c4100aa4155bb867577abe8789c4449c0335825849682fbc20d51c1ed7adad1"
    sha256 cellar: :any_skip_relocation, ventura:       "d77ec24aa15e5c94cf4ad8fcaec190a03d4b16c742afcf1132917b56a9c07edb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c694c4cba5c706ebbabec6c7ae8018a567568744cb1867b8cf4f3dca1f70d974"
  end

  depends_on "pcre"

  def install
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
