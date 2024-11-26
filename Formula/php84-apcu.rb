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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.1-106"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "ec3e2e369663e35b161d76c2487fe6fa60272a1bd9ce5b6b36c5972a36236d94"
    sha256 cellar: :any_skip_relocation, ventura:       "3032636c959adbb5d2bea46adeb964dd3c42f1c65ba271522a178de2280e63d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ff36c01787e1963a1a6835bda8da70bf386d467d39ffa1a306e89c865be4e89"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "b37278764c134c926c3969264b1bb4d5377f44c5dbf97c2e4f2d1738c4adf416"
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
