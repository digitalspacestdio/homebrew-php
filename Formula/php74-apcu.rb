require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Apcu < AbstractPhp74Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  #url "https://github.com/krakjoe/apcu/archive/v5.1.17.tar.gz"
  #sha256 "e6f6405ec47c2b466c968ee6bb15fc3abccb590b5fd40f579fceebeb15da6c4c"
  #head "https://github.com/krakjoe/apcu.git"
  url "https://codeload.github.com/krakjoe/apcu/tar.gz/1f98e34d936e1841e18fe5c25fdc64389456cdbc"
  sha256 "9f8ddc1232328108c29714fc7686db476dd630ffb94004f0fa055e1eae68dd26"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "1f98e34"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7a57a6405c50c99cf064cbc4fd49d130b4ae4197b2870814766eb8fa63e270e2"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "549aeb587dbbd5f39f44027f434a12c9748b1a73d5530e63f634397041f89fdb"
    sha256 cellar: :any_skip_relocation, sonoma:        "4220af5e74274b49c979f839a8ed9135e1a11c680ebc8731e6cc82ec1660eeba"
    sha256 cellar: :any_skip_relocation, monterey:      "a43dc9d8cda72194896e20080c502e131fcbbb4ab63dbff26e76cf987a0c3bae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "afdbb45b57564d1e1df978737fc58ba2e0b2dbc1c02023f78ebf75159dfb3139"
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
