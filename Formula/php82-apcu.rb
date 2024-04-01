require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Apcu < AbstractPhp82Extension
  init
  desc "APC User Cache"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.22.tar.gz"
  sha256 "dfd3e1df434fe84439da499e06d0857fd06dea5572df910d830b1d6474393b08"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "5.1.22"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "53170b1763c196d23b468637b5b64ce716cabc002af3cc8b3c19a3b81d4371a0"
    sha256 cellar: :any_skip_relocation, sonoma:        "aff6f39b046e99f5d4875e7f3019ee9ba8f8343adf41d4cf9c5d7b5750170934"
    sha256 cellar: :any_skip_relocation, monterey:      "a82b4a66268610400467c15c953db3e65edbcbb0b6b06449914e7da6507c311d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1105c9813343af757e7c5d8e31bccfa1538aa1e65d2fb21dd26abaadbb4b5648"
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
