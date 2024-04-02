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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "45ba6f8e077b452ab90984287f0bbcf34bdb2f7105edd7dbdd4ab911587c9195"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b319cd52dea028cf99d5594d50928c179da15540cdf32dfa01b5379a7d7cc318"
    sha256 cellar: :any_skip_relocation, sonoma:        "aa534be574cf0f9c578aa87b434501618cc2db4171f58e48725c985a1e6cf858"
    sha256 cellar: :any_skip_relocation, monterey:      "b32cf737ca6bfb1138f6c1a2197928743c9b24333fc8fcb950500fb16c859e9c"
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
