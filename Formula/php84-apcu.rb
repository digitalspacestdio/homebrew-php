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
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/8.4.0beta5-100"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5a203e23d2d7bddc80b055a95da644852f2eb62bb88b0d2c4b8fd8a575539738"
    sha256 cellar: :any_skip_relocation, ventura:        "512798bd92659d1bc4fda4b007cda1739006f3469ab8d23ba882a2f60b170809"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2117da839e2103ba41b83fd7c98d97e025d691c6d2e0569b8717ee22e23e75d8"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "04fa1bea55995dd0e4eccb0742d953fc9edc2230dacd275c669f610e985d10e7"
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
