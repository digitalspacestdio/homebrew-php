require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "201da371829729adea9658a59908a164579943e854702574aed2671412422dfa"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "57e7f7b2b1c07f50c54d9ac2d15d03d6383ed2268b2e035009e83527a00096a9"
    sha256 cellar: :any_skip_relocation, monterey:       "c4485c6c3827d70729a703b6fc6b3d555f8dfeed6a092659c98b0946a4fe855f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0c0391aee659558fadcaa789a44fb42b59672494eb364bbad17247a37390535e"
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
