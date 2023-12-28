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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c65d6504a6413ec9499a534a9f6c93ecc0ede831901a13ee16e6c15fc8a4d54e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5c9585f171cf601054e3ad6aaac64b90f39ca970eecff0d0eb62b38d2c56a4ab"
    sha256 cellar: :any_skip_relocation, sonoma:        "72d3b6b74a131fca0a8c457afff9cf0505cd648a1f865be98f86c2b64d476d28"
    sha256 cellar: :any_skip_relocation, ventura:       "61182ed029a159879b252f9b3f57819916c8713acbd6a8e5b326f91322511ae4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2388555c8ee967ec8becf2cdd4336b6fb242e1b072f0338da3df373dcebd6403"
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
