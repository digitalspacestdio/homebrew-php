require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php84Apcu < AbstractPhp84Extension
  init
  desc "APC User Cache"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.24.tar.gz"
  sha256 "8b16f76dba51ec14263212ee1f618b06e132246a98ce3ed6961104585b773c94"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  revision PHP_REVISION

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.4-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c0cbab5bf4ed4a7575b8c96391ccbccaa8558952e4baee1a14ab9a428f5b4bb4"
    sha256 cellar: :any_skip_relocation, ventura:       "bfe35c9a85c8349dbe9dc1abf1672e5f9118a6e5ae02aaead9321138ed86391b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "74d3785b511d4f7a2e91a8c872b531eb26b703cf473b7970e2cf32a02c792167"
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
