require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Apcu < AbstractPhp70Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f94bd0e4c5573e71eb4dd6bbfb02b618f805ecbb309ce90d6ed0166890237718"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9969fb34f43619642dfed96535e5b208389bedf9e5b29efb2d14bb711dbe2cc8"
    sha256 cellar: :any_skip_relocation, sonoma:        "1309a9b29dbdac51799e9c45edbbd93cecd175664ab85e9a74c4c6c695120a2d"
    sha256 cellar: :any_skip_relocation, monterey:      "79c6bf90b6fdd6acc39ff8dba80ff645db07fdf573711232cdfe4f09382bd351"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d25c70b6b0c6f1c88479b431b24b7ee060405655598d7bff0d37e7f635b3a86"
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
