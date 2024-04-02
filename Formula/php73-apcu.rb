require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Apcu < AbstractPhp73Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.17.tar.gz"
  sha256 "e6f6405ec47c2b466c968ee6bb15fc3abccb590b5fd40f579fceebeb15da6c4c"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9f4408edc447d77e376139e4e88a733c0ceba467c5c52a7900aca4f73ef81137"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9e98e9381d0c6872392e8635912cdcd974f4af263e79b5c5da7f89949134cf04"
    sha256 cellar: :any_skip_relocation, sonoma:        "588e57751822e7dc72e296e0776c03ed6e4fced44a01dacc2f091b5962db857c"
    sha256 cellar: :any_skip_relocation, monterey:      "cdd1874d87f5e0b242f49f8a9fdec65e936b09f87b7859e5cb0aa64ec671d198"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df67de3cad5c551416f2cc22112856dac73d4275ee9e7e0b171eb4db01f2a6a2"
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
