require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Apcu < AbstractPhp83Extension
  init
  desc "APC User Cache"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.23.tar.gz"
  sha256 "1adcb23bb04d631ee410529a40050cdd22afa9afb21063aa38f7b423f8a8335b"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "860ab5ce8951a49d42280179094a22397803cd884baa01c1c525d54c98ddcb69"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a1b9f04414f019717fc52140e48ef0bd99112b630dd7b037ec7a0e1a137d1d0c"
    sha256 cellar: :any_skip_relocation, sonoma:        "19fd96d237564bd45ce300646badee8555fc9dfbb0a5cc5dafdb6e10a4903f9c"
    sha256 cellar: :any_skip_relocation, monterey:      "75584ef070bd3c370a950e072c14673053736be3b72d8d795a7ce3371dd0d831"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ac9b5c2510dd2958ef71f8a6793f3f55070b1d3d4994ee9f286de6f0a22fcf2"
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
