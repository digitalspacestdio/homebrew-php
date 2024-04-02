require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Apcu < AbstractPhp72Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "050a697a0f264986ff6e252a6c80b8bebdfd841cd1be71f4a475841ddcdf44e4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7f9c124c5164ecca7169daad0edb5648064bc9dc54fb7804dfecdaf6633c2503"
    sha256 cellar: :any_skip_relocation, sonoma:        "9b9c6e1583653ba5569c6b7ee2fe83e1562cbcecc6ec2fb4dedf7086c90281a9"
    sha256 cellar: :any_skip_relocation, monterey:      "96764401b2e153af45aa48785c432408176a9025105c376e70f28697e216d9dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b6e48b115f30672dbbcdf15c812f75a92f8bfc90247a95105ee7ffb32d8e6f75"
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
