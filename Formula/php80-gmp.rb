require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php80Gmp < AbstractPhp80Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 1


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php80"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "29ed3d3e169f4941c0ad0943e283011450fd2867ad29764f7e6b9d0f5aec0313"
    sha256 cellar: :any_skip_relocation, sonoma:        "481bc88427249a0fbee401ac1063d69401f5923d5b50caf4d73eecc79924dc7e"
    sha256 cellar: :any_skip_relocation, ventura:       "60399b9afaad0f00a035a4a8b818d37663692b83c772ad54a32502e5642860dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "23e4a2337b4324edcd330ca186040aab866ee7184db0cd7ee1251dffb7277321"
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
