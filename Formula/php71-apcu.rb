require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Apcu < AbstractPhp71Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.1.33-103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "591606cf95c7ef7617020591ce0d1ac517b0376e3624c1471be25effdaedae7b"
    sha256 cellar: :any_skip_relocation, monterey:       "d74e8ccdcc149259945118e7130647c087d77f54084f5df3fe3d5635fd246171"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6ca7897127d95008f1c5c19d50b647174f81d77ad4c38fa105683d713271b1b"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "01383e8eaa5f8c8887e3a3c4c06dcd38e2a99c3d8ce139c72cb1e55fea07d2ef"
  end
  depends_on "pcre2"
  revision PHP_REVISION

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
