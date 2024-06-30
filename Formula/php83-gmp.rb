require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Gmp < AbstractPhp83Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://l2i5.c19.e2-3.dev/homebrew/php/8.3.8-106"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8d609374f64ee961c11d8feaac967883a103860aa889a1fec7ca7d2ba31a9160"
    sha256 cellar: :any_skip_relocation, monterey:       "c5937dd14020d27d2f32e8be746aaf17472c7282c5a5193eb78c406b6b313efd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6aca781fdf38c2dc98cba813e70ea3fe66c9ac61df5b882374f22bbcd2fdbe9"
    sha256 cellar: :any_skip_relocation, aarch64_linux:  "36404ecfa3653ebd1b70307eb18c68c878de8c9b928ff8e2916f7e1757484e42"
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
