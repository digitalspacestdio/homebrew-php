require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Apcu < AbstractPhp56Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.11.tgz"
  sha256 "454f302ec13a6047ca4c39e081217ce5a61bbea815aec9c1091fb849e70b4d00"
  head "https://github.com/krakjoe/apcu.git"
  revision PHP_REVISION
  
  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/5.6.40-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1b45c4608930213459b85d47d28f46cf75b4d7f44970f305cafe34576086a6be"
    sha256 cellar: :any_skip_relocation, monterey:       "bce858f40bcd70bd2f9e4d309052daba6dc6dc09ae2364a2869b103745bd1df0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e6559278098515874485a178ee6857dfba635f8037d52d522f963df76cffb3aa"
  end


  option "with-apc-bc", "Whether APCu should provide APC full compatibility support"
  depends_on "pcre2"

  def install
    Dir.chdir "apcu-#{version}" unless build.head?

    ENV.append "LDFLAGS", "-L#{Formula["pcre2"].opt_prefix}/lib"
    ENV.append "CPPFLAGS", "-I#{Formula["pcre2"].opt_prefix}/include"

    args = []
    args << "--enable-apcu"
    args << "--enable-apc-bc" if build.with? "apc-bc"

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
