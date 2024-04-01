require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Gmp < AbstractPhp72Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php72"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "36795fbd0c2aae538f98ae2a651b66787b5bd6bb862a407d253c22eb8bfca2ef"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1909979f33bb38de89c10df00f8ee1516270dba963d5cbd773fde019e81a2867"
    sha256 cellar: :any_skip_relocation, sonoma:        "0023de42c0842c43988ba1f789021669a964855b4bc5c148b7990139263b233a"
    sha256 cellar: :any_skip_relocation, monterey:      "fc497bb4f09b3f9121669e1e16ded7fb61252a2373bea15d35b7a3fe992fac0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86a527b66f7e7b5301e01125d80e80484a1fdd8f46066d35c867098b5200982b"
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
