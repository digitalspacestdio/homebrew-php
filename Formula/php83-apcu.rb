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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d0cc00a135fe67282f7be4b05e39feb90d359ba1dc5e578614b541c18220e2dd"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "596af9356f5c97afd022f1ce618d05ea73ecc0f8c3e2962ae24eb7c727251bb0"
    sha256 cellar: :any_skip_relocation, sonoma:        "19fd96d237564bd45ce300646badee8555fc9dfbb0a5cc5dafdb6e10a4903f9c"
    sha256 cellar: :any_skip_relocation, monterey:      "4837b8f9570e8276adc2c4a3406ef3a99ce48739c6485f2b625814cac61d99e7"
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
