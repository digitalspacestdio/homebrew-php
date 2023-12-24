require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 18


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php70"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "da8c0807a3ac56448ccbc7b26eeea5f2be201bdb325cd7a97c5af1307603769c"
    sha256 cellar: :any_skip_relocation, ventura:       "61182ed029a159879b252f9b3f57819916c8713acbd6a8e5b326f91322511ae4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e36863ab95ed448042852c48614b6201f79e33bc280974f91a5cadec0e0d9d21"
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
