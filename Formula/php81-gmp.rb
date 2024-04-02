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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9a9a90b8aae7bec6039b287815d8ce5d06f84acc943cba6deb510d35f4fd65a5"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "414c562d000eff382773311dc3e421bc871ab51cf8ab993820833d4c265e0c0d"
    sha256 cellar: :any_skip_relocation, sonoma:        "9afa5603508a33696fe734adda3a1863ce5592bc699f3bf8b91728e1294573a1"
    sha256 cellar: :any_skip_relocation, monterey:      "28c5b70a17d051acaf0ebce7cb702e064b529d9fc2c8e1f37c42e81041e438a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50848d7c594d0f8d6ef3caef302f7f1b209ed66c9f0824eeca56d02efea56902"
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
