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
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php56"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8b8364699af7fb1e8a6ff1a1101b0cf1950075849ad65e9a3ec1fe7042b08795"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a92c88490831f4ba08b87fb8df5c2cc3182c6d9bf9ce53ed0bfee50e7a06adc9"
    sha256 cellar: :any_skip_relocation, sonoma:         "f3facc85c43320eadb80fed100a26e2780e324929101f2817ca0d9db4fee153d"
    sha256 cellar: :any_skip_relocation, monterey:       "19cc5583e8c7f7a31b8747951a8fdc557335d601dda57af1354da9aab9b58568"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "df23581234e7fc41d17f6719056153135c89bbad39c9acad8faf3cb877141d4a"
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
