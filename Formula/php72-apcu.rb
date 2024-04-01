require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Apcu < AbstractPhp72Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5f89bd881c69cd8027956f896db2b1585e6202316b04b28e75cfb8921665e8af"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "821c7280716dec63b018c59651e5fce5bd7a5066705cdfd932070ee087e09232"
    sha256 cellar: :any_skip_relocation, sonoma:        "17bcc714172157658936145c905efc0d5d6c3cfbcc5e30c168cf9c7b698b81cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6e1428e7476cb958dbbc0ad7ab67e8a3d0f401a91ab8ee0b5c0d60cdd64e6fbd"
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
