require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php81Gmp < AbstractPhp81Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php81"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8487ffbd8b51abc40ac94428d71723c5443fd55880e365b52716491dd2959ddf"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "08f196bcd549d9ab381b4e0e5aec8f026f0a54e7b6f4212bda4a71361d247164"
    sha256 cellar: :any_skip_relocation, sonoma:        "e341a2048e5b981e7ca10e1eb945f6be4249b9142b64f8fe56b07b5c1fb82d65"
    sha256 cellar: :any_skip_relocation, monterey:      "28c5b70a17d051acaf0ebce7cb702e064b529d9fc2c8e1f37c42e81041e438a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8402e4772f3ad2487fc4f8a3ad9353a2aaed1bc5a0ce5e77866a7934e1545476"
  end

  depends_on "gmp"

  def install
    Dir.chdir "ext/gmp"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                           "--with-gmp=#{Formula["gmp"].opt_prefix}"
    system "make"
    prefix.install "modules/gmp.so"
    write_config_file if build.with? "config-file"
  end
end
