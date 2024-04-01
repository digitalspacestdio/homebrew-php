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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4479edc3df3fcb65a2527f8221292eb244e483861dee8c8c16d346198bc6aa89"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9e98e9381d0c6872392e8635912cdcd974f4af263e79b5c5da7f89949134cf04"
    sha256 cellar: :any_skip_relocation, sonoma:        "588e57751822e7dc72e296e0776c03ed6e4fced44a01dacc2f091b5962db857c"
    sha256 cellar: :any_skip_relocation, monterey:      "9d644a61dc96b2a93d7efbeb6a2bb5c955bdfc102d5a9d6fe05cee35e04bf9e4"
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
