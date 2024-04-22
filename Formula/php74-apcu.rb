require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Apcu < AbstractPhp74Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  #url "https://github.com/krakjoe/apcu/archive/v5.1.17.tar.gz"
  #sha256 "e6f6405ec47c2b466c968ee6bb15fc3abccb590b5fd40f579fceebeb15da6c4c"
  #head "https://github.com/krakjoe/apcu.git"
  url "https://codeload.github.com/krakjoe/apcu/tar.gz/1f98e34d936e1841e18fe5c25fdc64389456cdbc"
  sha256 "9f8ddc1232328108c29714fc7686db476dd630ffb94004f0fa055e1eae68dd26"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "1f98e34"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b220533916464381b6687f70deae7ec1bf71f5ced2c0a9353c887abf7d04d504"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "84cd482daddfb407f07a32b8fffbfd001c20b7d5e206af05648d6e77aea67273"
    sha256 cellar: :any_skip_relocation, monterey:       "3bc9c7b95185541afc4b1f7ca66ce5dfb349af520f9a372db7b99548115b2452"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aec99b3c7524b22904f51af6e68462c2a8f12c86b32a875260d5cde425f7aa91"
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
