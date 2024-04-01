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
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e1da6bfe94f0fded8971f2082136d9d9e0d23a64aafa00a89d1bb17f64d542ca"
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
