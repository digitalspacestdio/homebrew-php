require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php73Gmp < AbstractPhp73Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "33f7cee89050ac6af31cb231eb789b8a67d16197bd1cd241b6b510c53b02efeb"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9cb50eaa2b51a6a0506fe01aca20f2d062ffdecaae5b9be017e26e8f0d52fcea"
    sha256 cellar: :any_skip_relocation, sonoma:        "e0846568057de3c791be0900973316bd046b01573934bbb2f6d4c0319a1637f6"
    sha256 cellar: :any_skip_relocation, monterey:      "4511916d064dc63ab3e7c1327c4900e0da3dce37d4a8185099fe2a13daebdedc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "814e847f3206ca86ec9b015e8532e0122936d4235a4d045faefdf366204e3c9a"
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
