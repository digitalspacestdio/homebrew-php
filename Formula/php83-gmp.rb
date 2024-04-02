require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php83Gmp < AbstractPhp83Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "257026c46aadde68e3bef577c7a529dbe872cbff087ce3fe789ec6917e8c2e88"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0f1ee11886a5d6697e13491c651f076413c4dd9452228d59fe31ab9cdfc834bb"
    sha256 cellar: :any_skip_relocation, sonoma:        "724043ebd358b8d8c68c01922c4c2b00f693e48e90b939eb6bb0250ac47a4224"
    sha256 cellar: :any_skip_relocation, monterey:      "d8926d95368885fed6c22e281b009a93dc4640d1ad468022208921f7222ad8e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "649a767be318e7aac4a2f8dceaf3725680233e59c81fb549526780183d2fb374"
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
