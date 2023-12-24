require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Apcu < AbstractPhp73Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.17.tar.gz"
  sha256 "e6f6405ec47c2b466c968ee6bb15fc3abccb590b5fd40f579fceebeb15da6c4c"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  revision 3

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "19b951391078eb51221556c8c8db159a4ea2d582b931a4e557d2a531f8942565"
    sha256 cellar: :any_skip_relocation, ventura:       "253ceb4bd887f1996c3c119906b16206cd872a98f5f967d4cd1d5ca86ff635c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46ed7950ee911f2e0a62242009369f8fc19a28061b8fef971e88b6b19b340c06"
  end

  depends_on "pcre"

  def install
    pcre = Formula["pcre"]
    cc_opt = "-I#{pcre.opt_include}"
    ld_opt = "-L#{pcre.opt_lib}"

    args = []
    args << "--enable-apcu"
    args << "--with-cc-opt=#{cc_opt}"
    args << "--with-ld-opt=#{ld_opt}"

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
