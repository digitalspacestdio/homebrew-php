require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Apcu < AbstractPhp80Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.18.tar.gz"
  sha256 "0ffae84b607bf3bfb87a0ab756b7712a93c3de2be20177b94ebf845c3d94f117"
  head "https://github.com/krakjoe/apcu.git", :branch => "master"
  version "5.1.18"
  revision PHP_REVISION

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ef4ae44ce54173df96c65b55de613ee24860a362f40b33efcaa7901519bb350e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a95d38dba3208eafc218dfde66a91a928b47a744d9c15a7599d965eb2108567e"
    sha256 cellar: :any_skip_relocation, monterey:       "96f43286ee9506050ba0d4b7d10ac0fdbc962719522c66211c862dd3f033ef9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b1259765fa6748f2f0ffd6f19dd2703a913e750311e1da7bee7279f35bdeecfe"
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
