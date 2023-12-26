require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gmp < AbstractPhp71Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision 19


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php71"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f2ed5b52a1d67ab2c4a2846cd15c74b44f9a5d664091a40f679a55d53c041c98"
    sha256 cellar: :any_skip_relocation, sonoma:        "3bb9c54e607756fac2983a62a1521ed08b9a1243782f7386c2825cb268adadf4"
    sha256 cellar: :any_skip_relocation, ventura:       "aac097cac48a812510067d3224479764f407b83ee757e0409e2403ca5abd3422"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "68fd8e22aba28ebf03f866b094525269780a679fee5ad469335750b1b27a1a9e"
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
