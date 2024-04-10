require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php74Gmp < AbstractPhp74Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php74"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c7c22cc2c10599ce5ee467d7450911862b06c5ae1a781a1a72b30bd603eeb0fb"
    sha256 cellar: :any_skip_relocation, monterey:      "c7a69b2533a1f9394817b556337a3b9b91c7392593b93ff9b14b94bbfb82e497"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "398b30b3cd9374fa0e097ac19867239c0b9acb58162f9c9612f5b50521f74979"
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
