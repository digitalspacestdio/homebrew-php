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
    sha256 cellar: :any_skip_relocation, arm64_ventura: "eac0e6e7fe8829bd3f02f3cf016cda24f6442e858154ecccb70648a9a8abdf5d"
    sha256 cellar: :any_skip_relocation, sonoma:        "481bc88427249a0fbee401ac1063d69401f5923d5b50caf4d73eecc79924dc7e"
    sha256 cellar: :any_skip_relocation, ventura:       "60399b9afaad0f00a035a4a8b818d37663692b83c772ad54a32502e5642860dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "902169e771d744e7234da07c9f452ca3a28fc28dd8fd683df33280816d92edd4"
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
