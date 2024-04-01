require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php82Gmp < AbstractPhp82Extension
  init
  desc "GMP core php extension"
  homepage "https://php.net/manual/en/book.gmp.php"
  revision PHP_REVISION


  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  bottle do
    root_url "https://f003.backblazeb2.com/file/homebrew-bottles/php82"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "aa4d06beeb48282b4eba41f0521726bd4ef096c76301f9fb4bf3498627dd2412"
    sha256 cellar: :any_skip_relocation, sonoma:        "c45f1911e8d81921b45ab7c6f60879927dbcf08abca54552bbfaaeae576ea5ab"
    sha256 cellar: :any_skip_relocation, monterey:      "d4571ed8466b7567a79b0930d54ff22c465a9f641c396035c1ee0312355c21ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b082003ac17a216ee8b52c1223e47d00804a0efe205521de8b299def0d2e5c9"
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
