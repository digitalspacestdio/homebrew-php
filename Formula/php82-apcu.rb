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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.2.21-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eaefc78a6cb43fd86a014521bb2e9c2dd6aa5bbed3db96b151b439c295647209"
    sha256 cellar: :any_skip_relocation, monterey:       "8a13521971cc2193fab7041502d09f543e722629dc06b16a3ef8aaa4c038b8db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7b7a82c89f9f84a06e3e481e946fdc815373c566f0cb96a4b7cd17d51195f691"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "b5526d004cd6a1bda937c8137de4477a9618fb7fede91babb958e8930728e47f"
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
