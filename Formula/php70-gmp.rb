require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmp < AbstractPhp70Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_URL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://pub-7d898cd296ae4a92a616d2e2c17cdb9e.r2.dev/php/7.0.33-111"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "081819973df1132f09f635c66cd7d5fc960a9adecc281fc45102e7514eac2908"
    sha256 cellar: :any_skip_relocation, ventura:       "ffba21da751bd84902a96ad06e4b858fbdb604c06149e49c4b12f790973f6421"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b7a3be043dab2ebc46ae390b9a0ca8590d2342d7bd2e4ab2c116838bad6ad92"
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
