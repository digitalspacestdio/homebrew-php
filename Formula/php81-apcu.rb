require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Apcu < AbstractPhp81Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.21.tar.gz"
  sha256 "6406376c069fd8e51cd470bbb38d809dee7affbea07949b2a973c62ec70bd502"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "5.1.21"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "086690d056f9883aa2bd79834340ee2c9d322f1e5c67c9c78553e23abff89404"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "49b3048f7b0ba5060c629b65bd8233094fb7b3678bb3c30121a76e7d701154b6"
    sha256 cellar: :any_skip_relocation, sonoma:        "05eabd40d3d1f4ecad487c6db89560358830dd279f52ffd4d8f24fd1f9061d34"
    sha256 cellar: :any_skip_relocation, monterey:      "e7533cc7c897de760eb70f7457c6347f4f08d0858ce1349f97f1054930fd4857"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eed3c4ba87d04807d7ee7b882ebdcdc2f2b7cfd8aae343ae725041228b9841ae"
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
