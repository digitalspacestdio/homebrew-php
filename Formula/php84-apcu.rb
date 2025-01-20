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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.3-106"
    sha256 cellar: :any_skip_relocation, ventura: "9b9e4b38612c7551451d4767cc22c3fcfa3feea044dffbbe563575df398b14c9"
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
