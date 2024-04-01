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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c06ef2cc673573a395a8be249c9a913c1590023ba524f32ab33531c28d55b32c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4370f5a0c006a7e4cc5edfabdd5eeb9a4ccd806d310263b9a8b0894e521c10f8"
    sha256 cellar: :any_skip_relocation, sonoma:        "e16abe0d80f9f53507ea341ca9d0abbc4da1d20afc92b9ba69660d7a85e78246"
    sha256 cellar: :any_skip_relocation, monterey:      "b7337cea95fad99b6042f72c4a6a1aa8916aa145274aac8a37092f0522ce666b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8af31db021f572f2a486d099afb9e1edab1e75378534f3cb428f6c972be98b0c"
  end
  depends_on "pcre2"
  revision PHP_REVISION

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
